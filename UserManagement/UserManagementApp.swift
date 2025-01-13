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
        }
        .modelContainer(for: [Person.self])
    }
}

struct ContentView: View {

    var body: some View {
        PeopleView()
            .environment(\.dataService, DataService())
//            .environment(\.dataService, MockDataService())
    }
}
