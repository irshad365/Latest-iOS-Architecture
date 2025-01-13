//
//  Person.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation
import SwiftData

@Model
public class Person: Codable, Identifiable, @unchecked Sendable {
    @Attribute(.unique) public var id: UUID
    public var name: String
    public var age: Int
    
    public init(id: UUID, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    // Codable
    
    enum CodingKeys: CodingKey {
        case name
        case age
        case id
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(id, forKey: .id)
    }
}
