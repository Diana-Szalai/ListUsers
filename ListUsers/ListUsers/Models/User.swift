//
//  User.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: Int
    let name: String
    let userName: String
    let email: String
    let phone: String
}

// MARK: - Equatable
extension User: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.userName == rhs.userName
    }
}
