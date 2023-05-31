//
//  APIServiceError.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

enum APIServiceError: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case invalidURL
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid url"
        default:
            return nil
        }
    }
}
