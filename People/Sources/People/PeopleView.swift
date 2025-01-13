//
//  PeopleView.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import SwiftUI

public struct PeopleView: View {
    @State private var viewModel: PersonViewModel
    
    public init(dataService: DataServiceProtocol) {
        _viewModel = State(wrappedValue: PersonViewModel(service: dataService))
    }
    
    @State private var searchtext: String = ""
    public var body: some View {
        NavigationView {
            content
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
    
    var content: some View {
        VStack {
            if let error = viewModel.error {
                Text(error)
                Button("Reload") {
                    Task {
                        await viewModel.loadPeople()
                    }
                }
            } else {
                List(viewModel.filteredPeople , id: \.id) { person in
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
    }
}

#Preview {
    actor MockDataService: DataServiceProtocol {
        func getPersonList() async throws -> [Person] {
            return [
                Person(id: UUID(), name: "John", age: 30),
                Person(id: UUID(), name: "Doe", age: 30)
            ]
        }
    }
    return PeopleView(dataService: MockDataService())
}
