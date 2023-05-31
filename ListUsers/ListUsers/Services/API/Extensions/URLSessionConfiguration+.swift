//
//  URLSessionConfiguration+.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

extension URLSessionConfiguration {
    
    static func configuration(resourceTimeout: TimeInterval,
                              requestTimeout: TimeInterval,
                              cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = cachePolicy
        config.timeoutIntervalForResource = resourceTimeout
        config.timeoutIntervalForRequest = requestTimeout
        
        return config
    }
}
