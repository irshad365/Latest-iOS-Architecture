//
//  ContentView.swift
//  UserManagement
//
//  Created by Mohamed Irshad on 1/12/25.
//

import SwiftUI
import Foundation

struct Person: Codable, Identifiable {
    let id: UUID
    let name: String
    let age: Int
}

enum NetworkError: Error, LocalizedError {
    case invalidUrl
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL String"
        }
    }
}

protocol DataServiceProtocol {
    func getPersonList() async throws -> [Person]
}

actor DataService: DataServiceProtocol {
    func getPersonList() async throws -> [Person] {

        guard let url = URL(string: "https://run.mocky.io/v3/f739147a-168f-42a2-ac6d-668bcbbb20a2") else {
            throw NetworkError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Person].self, from: data)
    }
}

actor MockDataService:DataServiceProtocol {
    func getPersonList() async throws -> [Person] {
        return [
            Person(id: UUID(), name: "John", age: 30),
            Person(id: UUID(), name: "Doe", age: 30)
        ]
    }
}

@MainActor
class PersonViewModel: ObservableObject {
    private let service: DataServiceProtocol
    init(service: DataServiceProtocol) {
        self.service = service
        self.loading = false
        self.error = nil
    }
    
    @Published var loading: Bool
    @Published var people: [Person] = []
    @Published var error: String?
    func loadPeople() async {
        loading = true
        do {
            self.people = try await service.getPersonList()
            self.filteredPeople = self.people
            self.error = nil
        } catch {
            self.error = error.localizedDescription
        }
        loading = false
    }
    
    @Published var filteredPeople: [Person] = []
    func filter(value: String) {
        guard !value.isEmpty else {
            self.filteredPeople = self.people
            return
        }
        self.filteredPeople = self.people.filter{ $0.name.contains(value)}
    }
}

struct PeopleView: View {
    @StateObject private var viewModel: PersonViewModel
    @State private var searchtext: String = ""
    init(viewmodel: PersonViewModel) {
        _viewModel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.error {
                    Text(error)
                    Button("Reload") {
                        Task {
                            await viewModel.loadPeople()
                        }
                    }
                } else {
                    List(viewModel.filteredPeople, id: \.id) { person in
                        HStack {
                            Text(person.name)
                            Text(String(person.age))
                        }
                    }
                    .overlay(
                        Group {
                            if viewModel.loading {
                                ProgressView()
                            }
                        }
                    )
                }
            }
            .navigationTitle("Demo")
        }
        .task {
            await viewModel.loadPeople()
        }
        .refreshable {
            await viewModel.loadPeople()
        }
        .searchable(text: $searchtext)
        .onChange(of: searchtext) {
            viewModel.filter(value: searchtext )
        }
    }
}


#Preview {
    let viewmodel = PersonViewModel(service: MockDataService())
    PeopleView(viewmodel: viewmodel)
}
