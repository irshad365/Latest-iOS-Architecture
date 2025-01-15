//
//  NetworkSession.swift
//  Core
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public class NetworkSession: @unchecked Sendable {
    private init() {}
    public static let shared = NetworkSession()
    
    public func data<T: Codable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw CustomError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
