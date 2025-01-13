//
//  Person.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public struct Person: Codable, Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let age: Int
    
    public init(id: UUID, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}
