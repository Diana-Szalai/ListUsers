//
//  CurrentUserResponse.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

struct UserResponse: Decodable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}

struct UsersResponse {
    
    var users: [UserResponse]
}

// MARK: - Decodable

extension UsersResponse: Decodable {
        
    init(from decoder: Decoder) throws {
        var unkeyedContainer = try decoder.unkeyedContainer()
        var users = [UserResponse]()
        
        while !unkeyedContainer.isAtEnd {
            let user = try unkeyedContainer.decode(UserResponse.self)
            users.append(user)
        }
        
        self.users = users
    }
}
