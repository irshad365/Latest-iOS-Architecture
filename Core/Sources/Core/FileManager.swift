//
//  Decoding.swift
//  Core
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public class FileManager {
    public static func contents<T: Codable>(of file: String, in bundle: Bundle) throws -> T {
        guard let path = bundle.url(forResource: file, withExtension: "json") else {
            throw NetworkError.invalidPath
        }
        
        let data = try Data(contentsOf: path)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
