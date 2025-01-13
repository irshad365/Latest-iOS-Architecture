//
//  PeopleView.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import SwiftUI
import Core
import SwiftData

public struct PeopleView: View {
    @Environment(\.dataService) private var service
    @Environment(\.modelContext) private var modelContext
    @State private var loading: Bool = false
    @State private var error: String? = nil
    @State private var searchtext: String = ""

    public init() {}
    
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
    
    public var body: some View {
        NavigationView {
            content
                .navigationTitle("Demo")
        }
        .task {
            await loadPeople()
        }
        .refreshable {
            await loadPeople()
        }
        .searchable(text: $searchtext)

    }
    
    var content: some View {
        VStack {
            if let error = error {
                Text(error)
                Button("Reload") {
                    Task {
                        await loadPeople()
                    }
                }
            } else {
                ListView(searchText: searchtext)
                .overlay(
                    Group {
                        if loading {
                            ProgressView()
                        }
                    }
                )
            }
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

#Preview {
    PeopleView()
        .environment(\.dataService, MockDataService())
}
