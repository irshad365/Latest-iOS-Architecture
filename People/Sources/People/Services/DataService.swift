//
//  DataService.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation
import SwiftUICore


public extension EnvironmentValues {
    @Entry var dataService: DataServiceProtocol = DataService()
}

public actor DataService: DataServiceProtocol {
    public init() {}
    
    public func getPersonList() async throws -> [Person] {
        guard let url = URL(string: "https://run.mocky.io/v3/da80f53d-f4be-4b52-a3b1-645f09203a62") else {
            throw NetworkError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Person].self, from: data)
    }
}
