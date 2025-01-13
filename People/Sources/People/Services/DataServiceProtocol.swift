//
//  DataServiceProtocol.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public protocol DataServiceProtocol {
    func getPersonList() async throws -> [Person]
}
