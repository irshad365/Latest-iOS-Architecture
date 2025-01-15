//
//  PeopleListView.swift
//  People
//
//  Created by Mohamed Irshad on 1/15/25.
//

import SwiftUI
import SwiftData

extension PeopleView {
    struct ListView: View {
        init(searchText: String) {
            let predicate = (searchText.isEmpty) ? nil : #Predicate<Person> {$0.name.contains(searchText)}
            _people = Query(filter: predicate,
                            sort: [SortDescriptor(\Person.name)])
        }
        
        @Query private var people: [Person]
        
        var body: some View {
            List(people, id: \.id) { person in
                HStack {
                    Text(person.name)
                    Text(String(person.age))
                }
            }
        }
    }
}

 #Preview {
     PeopleView.ListView(searchText: "")
         .modelContainer(for: [Person.self])
 }
