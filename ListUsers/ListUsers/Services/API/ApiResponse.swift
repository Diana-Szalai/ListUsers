//
//  ApiResponse.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

struct ApiResponse: Decodable {
    
    // MARK: - Properties
    
    var statusCode: Int
    var message: String
    
    var isError: Bool {
        return statusCode != 200
    }
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "cod"
        case message
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeString = try container.decode(String.self, forKey: .statusCode)
        statusCode = Int(codeString) ?? 0
        message = try container.decode(String.self, forKey: .message)
    }
}
