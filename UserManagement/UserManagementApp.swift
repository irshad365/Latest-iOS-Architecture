//
//  UserManagementApp.swift
//  UserManagement
//
//  Created by Mohamed Irshad on 1/12/25.
//

import SwiftUI
import People

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
    @Environment(\.dataService) private var dataService

    var body: some View {
        PeopleView(dataService: dataService)
    }
}
