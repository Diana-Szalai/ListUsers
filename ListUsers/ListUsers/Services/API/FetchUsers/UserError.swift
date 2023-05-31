//
//  FetchUsersErrors.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

enum UserError: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case network(description: String)
    case parsing(description: String)
    case timeout
    case notFound
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .network:
            return "Request to API Server failed"
        case .parsing:
            return "Failed parsing response from server"
        case .timeout:
            return "Slow or no internet connection"
        case .notFound:
            return "Users not found."
        case .unknown:
            return "Something went wrong. Please try again later."
        }
    }
}
