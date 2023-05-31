//
//  UserServiceConstants.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

struct UserServiceConstants {
    
    enum UserAPI {
        static let scheme = "https"
        static let host = "jsonplaceholder.typicode.com"
        static let path = "/users"
        static let baseURL = "https://jsonplaceholder.typicode.com/users"
    }
    
    enum UserServiceAPIResponseCodes {
        static let notFound = 404
        static let unauthorized = 401
    }
}
