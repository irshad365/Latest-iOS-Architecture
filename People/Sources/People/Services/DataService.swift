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
        try await NetworkSession.shared.data(from: "https://run.mocky.io/v3/b031c584-e92e-4340-b073-7f2779cdb39f")
    }
}

public actor ErrorDataService: DataServiceProtocol {
    public init() {}

    public func getPersonList() async throws -> [Person] {
        try await NetworkSession.shared.data(from: "https://run.mocky.io/v3/37065906-898e-479f-9ab3-a7971558448d")
    }
}

public actor MockDataService: DataServiceProtocol {
    var throwError: Bool
    public init(throwError: Bool = false) {
        self.throwError = throwError
    }

    public func getPersonList() async throws -> [Person] {
        guard throwError == false else {
            throw CustomError.undefined
        }
        return try Core.FileManager.contents(of: "people", in: Bundle.module) as [Person]
    }
}
