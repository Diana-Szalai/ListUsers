//
//  ApiSessionConfiguration.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

struct ApiSessionConfiguration {
    static let defaultRequestTimeout: TimeInterval = 10
    static let defaultUploadTimeout: TimeInterval = 10
    
    var uploadTimeout: TimeInterval
    var requestTimeout: TimeInterval
    
    static let `default` = ApiSessionConfiguration(
        uploadTimeout: defaultUploadTimeout,
        requestTimeout: defaultRequestTimeout
    )
}
