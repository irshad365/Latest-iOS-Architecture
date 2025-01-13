//
//  DataService.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public actor DataService: DataServiceProtocol {
    public init() {}
    
    public func getPersonList() async throws -> [Person] {

        guard let url = URL(string: "https://run.mocky.io/v3/f739147a-168f-42a2-ac6d-668bcbbb20a2") else {
            throw NetworkError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Person].self, from: data)
    }
}
