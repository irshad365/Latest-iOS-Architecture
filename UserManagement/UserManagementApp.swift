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
    @State private var viewmodel = PersonViewModel(service: DataService())

    var body: some Scene {
        WindowGroup {
            PeopleView()
                .environment(viewmodel)
        }
    }
}
