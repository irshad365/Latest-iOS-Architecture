//
//  UserManagementApp.swift
//  UserManagement
//
//  Created by Mohamed Irshad on 1/12/25.
//

import SwiftUI

@main
struct UserManagementApp: App {
    var body: some Scene {
        WindowGroup {
            let viewmodel = PersonViewModel(service: DataService())
            PeopleView(viewmodel: viewmodel)
        }
    }
}
