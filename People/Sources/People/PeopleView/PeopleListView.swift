//
//  PeopleListView.swift
//  People
//
//  Created by Mohamed Irshad on 1/15/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.isSearching) private var isSearching
    
    private var error: String?
    private var reload: () -> Void
    init(searchText: String, error: String?, reload: @escaping @MainActor () -> Void ) {
        self.error = error
        self.reload = reload
        let predicate = (searchText.isEmpty) ? nil : #Predicate<Person> {$0.name.contains(searchText)}
        _people = Query(filter: predicate,
                        sort: [SortDescriptor(\Person.name)])
    }
    
    @Query private var people: [Person]
    
    var body: some View {
        VStack {
            if let error = self.error, isSearching == false {
                Text(error)
                Button("Reload", action: reload)
            }
           
            List(people, id: \.id) { person in
                HStack {
                    Text(person.name)
                    Spacer()
                    Text(String(person.age))
                }
            }
        }
    }
}

#Preview {
    ListView(searchText: "", error: nil) {}
        .modelContainer(for: [Person.self])
    
    ListView(searchText: "", error: "Error") {}
        .modelContainer(for: [Person.self])
}
