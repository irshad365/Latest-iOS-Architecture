//
//  PeopleView.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import SwiftUI
import Core
import SwiftData

@Observable @MainActor
class PeopleViewModel {
    var loading: Bool = false
    var error: String? = nil
    var people: [Person] = []
    
    private let service: DataServiceProtocol
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext, service: DataServiceProtocol) {
        self.modelContext = modelContext
        self.service = service
    }
    
    func loadPeople() async {
        loading = true
        error = nil
        do {
            let list = try await service.getPersonList()
            do {
                try modelContext.transaction {
                    for item in list {
                        modelContext.insert(item)
                    }
                    do {
                        try modelContext.save()
                    } catch {
                        self.error = error.localizedDescription
                    }
                }
            } catch {
                self.error = error.localizedDescription
            }
        } catch {
            self.error = error.localizedDescription
        }
        loading = false
    }
    
}

public struct PeopleView: View {
    @State private var searchtext: String = ""
    
    @State private var viewModel: PeopleViewModel
    public init(modelContext: ModelContext, service: DataServiceProtocol) {
        let viewModel = PeopleViewModel(modelContext: modelContext, service: service)
        _viewModel = State(initialValue: viewModel)
    }
    
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
            }
            ListView(searchText: searchtext)
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

struct ListView: View {
    init(searchText : String) {
        let predicate = (searchText.isEmpty) ? nil : #Predicate<Person> {$0.name.contains(searchText)}
        _people = Query(filter: predicate,
                        sort: [SortDescriptor(\Person.name)])
    }
    
    @Query private var people: [Person]
    
    var body: some View {
        List(people , id: \.id) { person in
            HStack {
                Text(person.name)
                Text(String(person.age))
            }
        }
    }
}

//#Preview {
//    PeopleView(modelContext: <#ModelContext#>, service: MockDataService())
//        .modelContainer(for: [Person.self])
//}
