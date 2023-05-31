//
//  ApiEndpointType.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

protocol ApiEndpointType {
    
    var httpMethod: String { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var urlComponents: URLComponents { get }
}
