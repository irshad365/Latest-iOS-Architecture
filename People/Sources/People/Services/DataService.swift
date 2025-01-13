//
//  DataService.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation
import SwiftUICore
import Core

public extension EnvironmentValues {
    @Entry var dataService: DataServiceProtocol = DataService()
}

public actor DataService: DataServiceProtocol {
    public init() {}
    
    public func getPersonList() async throws -> [Person] {
        try await NetworkSession.shared.data(from: "https://run.mocky.io/v3/37065906-898e-479f-9ab3-a7971558448d")
    }
}

public actor MockDataService: DataServiceProtocol {
    public init() {}
    
    public func getPersonList() async throws -> [Person] {
        try Core.FileManager.contents(of:"people", in: Bundle.module)
    }
}
