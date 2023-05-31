//
//  UserService.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation
import Combine

protocol UserServiceType {
    func currentUsers() -> AnyPublisher<UsersResponse, UserError>
}

class UserService: ApiService<UsersApi>, UserServiceType {
    
    func currentUsers() -> AnyPublisher<UsersResponse, UserError> {
        guard let request = makeRequest(endpoint: UsersApi.currentUsers)
        else {
            return Fail<UsersResponse, UserError>(error:
                    .network(description: "Invalid request"))
            .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, urlRepsone in
                guard let self = self else {
                    throw UserError.unknown
                }
                if let apiResponse = try? self.decoder.decode(ApiResponse.self, from: data),
                   apiResponse.statusCode == UserServiceConstants.UserServiceAPIResponseCodes.notFound {
                    throw UserError.notFound
                }
                return data
            }
            .decode(type: UsersResponse.self, decoder: decoder)
            .mapError { [weak self] error -> UserError in
                guard let self = self else {
                    return .unknown
                }
                return self.mapToUserError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func mapToUserError(_ error: Error) -> UserError {
        switch error {
        case is URLError:
            if let urlError = error as? URLError,
               (urlError.code == .timedOut || urlError.code == URLError.notConnectedToInternet) {
                return .timeout
            }
            return .network(description: error.localizedDescription)
        case is DecodingError:
            return .parsing(description: error.localizedDescription)
        default:
            return error as? UserError ?? .unknown
        }
    }
}
