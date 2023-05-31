//
//  APIService.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation
import Combine

class ApiService<Endpoint: ApiEndpointType> {
    
    private(set) var session: URLSession
    private(set) var decoder: JSONDecoder
    private(set) var bgScheduler: DispatchQueue
    
    init(session: URLSession = URLSession(configuration:
            .configuration(resourceTimeout: ApiSessionConfiguration.default.uploadTimeout,
                           requestTimeout: ApiSessionConfiguration.default.requestTimeout)
    ),
         decoder: JSONDecoder = JSONDecoder(),
         scheduler: DispatchQueue = DispatchQueue(
            label:"ApiServiceQueue",
            qos: .default, attributes: .concurrent)) {
        
        self.session = session
        self.decoder = decoder
        self.bgScheduler = scheduler
    }
    
    func makeRequest(endpoint: Endpoint) -> URLRequest? {
        guard let url = endpoint.urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod
        
        endpoint.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
