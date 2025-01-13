//
//  NetworkError.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidUrl
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL String"
        }
    }
}

