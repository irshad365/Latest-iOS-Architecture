//
//  UserManagementApp.swift
//  UserManagement
//
//  Created by Mohamed Irshad on 1/12/25.
//

import SwiftUI
import People
import SwiftData

@main
struct UserManagementApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.dataService, DataService())
//                .environment(\.dataService, MockDataService())
        }
    }
}

struct ContentView: View {
    @Environment(\.dataService) private var service
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        PeopleView(modelContext: modelContext, service: service)
            .modelContainer(for: [Person.self])
    }
}
