//
//  UsersRepository.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import Foundation
import Combine
import RealmSwift

protocol UsersRepositoryType: AnyObject {
    func currentUsers() -> AnyPublisher<[UserObject], UserError>
}

class UsersRepository: UsersRepositoryType {
    
    private let usersService: UserServiceType
    private let realmProvider: RealmProviderType
    private let bkgScheduler: DispatchQueue
    
    init(usersService: UserServiceType,
         realmProvider: RealmProviderType,
         bkgScheduler: DispatchQueue = DispatchQueue(label: "UsersRepository-queue",
                                                        qos: .default,
                                                        attributes: .concurrent)) {
        self.usersService = usersService
        self.realmProvider = realmProvider
        self.bkgScheduler = bkgScheduler
    }
    
    func currentUsers() -> AnyPublisher<[UserObject], UserError> {
        return usersService.currentUsers()
            .subscribe(on: bkgScheduler)
            .receive(on: bkgScheduler)
            .handleEvents(receiveOutput: { [weak self] usersResponse in // equivalent with do(onSuccess:)
                // map and save in bkg
                guard let self else { return }
                
                print("- handleEvents(receiveOutput")
                
                let userObjects = self.mapToDomainModel(response: usersResponse)
                self.save(users: userObjects)
                
            })
            .map { [weak self] usersResponse in
                // create umanaged copy before switch thread
                guard let self else {
                    return [UserObject]()
                }
                let userObjects = self.mapToDomainModel(response: usersResponse)
                
                print("- tryMap")
                
//                throw UserError.timeout
                
                return userObjects
            }
            .catch { [weak self] error in //returnam din cache un publisher in caz de err
                guard let self else {
                    return Result<[UserObject], UserError>.Publisher(.success([]))
                }

                print("Failed getting users with error: \(error)")
                
                // if .timedOut || .notConnectedToInternet
                if case UserError.timeout = error {
                    let managedUsers = self.getUsersFromCache()
                    
                    let unmanagedUserCopy = managedUsers.map({ UserObject(id: $0.id,
                                                                        name: $0.name,
                                                                        userName: $0.userName,
                                                                        email: $0.email,
                                                                        phone: $0.phone) })
                    
                    return Result<[UserObject], UserError>.Publisher(.success(unmanagedUserCopy))
//                    return Result<[UserObject], UserError>.Publisher(.success(managedUsers))
                    
                } else {
                    return Result<[UserObject], UserError>.Publisher(.failure(error))
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func mapToDomainModel(response: UsersResponse) -> [UserObject] {
        response.users.map {
            UserObject(id: $0.id,
                       name: $0.name,
                       userName: $0.username,
                       email: $0.email,
                       phone: $0.phone)
        }
    }
        
    func save(users: [UserObject]) {
        let threadCache = DataCache(provider: realmProvider)
        let saveResult = threadCache.addOrUpdate(objects: users)
        print("Users save successful: \(saveResult)")
    }

    func getUsersFromCache() -> [UserObject] {
        let threadCache = DataCache(provider: realmProvider)
        let existingData: Results<UserObject>? = threadCache.getAll()
        
        if let existingData, !existingData.isInvalidated {
            return Array(existingData)
        } else {
            return []
        }
    }
}
