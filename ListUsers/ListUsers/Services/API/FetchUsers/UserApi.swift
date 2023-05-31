//
//  UsersApi.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

enum UsersApi: ApiEndpointType {
    
case currentUsers
    
    var httpMethod: String {
        switch self {
        case .currentUsers:
            return HTTPMethod.get.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .currentUsers:
            return "/users"
            }
        }
    
        var headers: HTTPHeaders {
            switch self {
            default:
                return ["Content-Type": "application/json",
                "Accept": "application/json"]
            }
        }
    
        var urlComponents: URLComponents {
            var components = URLComponents()
            components.scheme = UserServiceConstants.UserAPI.scheme
            components.host = UserServiceConstants.UserAPI.host
            components.path = UserServiceConstants.UserAPI.path
            
            switch self {
            case .currentUsers:
                components.path = self.path
            }
            
            return components
        }
    
}
