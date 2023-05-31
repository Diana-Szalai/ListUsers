//
//  HTTP.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPParams = [String: Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
