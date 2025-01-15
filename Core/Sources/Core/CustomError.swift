//
//  NetworkError.swift
//  People
//
//  Created by Mohamed Irshad on 1/13/25.
//

import Foundation

public enum CustomError: Error, LocalizedError {
    case invalidUrl
    case invalidPath
    case undefined
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL String"
        case .invalidPath:
            return "Invalid File Path"
        case .undefined:
            return "Undefined Error"
        }
    }
}

