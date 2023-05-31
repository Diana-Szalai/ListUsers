//
//  SearchViewModel.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation
import Combine


class SearchViewModel: SearchUserViewModelType, ObservableObject {
    @Published var currentUsers: [User]?
    @Published var userError: UserError?
    
    private var subscriptions = Set<AnyCancellable>()
    private let usersRepository: UsersRepositoryType
    private let bkgScheduler: DispatchQueue
    
    init(usersRepository: UsersRepositoryType,
         bkgScheduler: DispatchQueue = DispatchQueue(label: "SearchUserViewModel-queue",
                                                     qos: .default, attributes: .concurrent)) {
        self.usersRepository = usersRepository
        self.bkgScheduler = bkgScheduler
        
        print("SearchViewModel - init")
        
        getCurrentUsers()
    }
    
    func getCurrentUsers() {
        usersRepository.currentUsers()        
            .receive(on: bkgScheduler)
            .map { usersObjects in
                usersObjects.map {
                    User(id: $0.id,
                         name: $0.name,
                         userName: $0.userName,
                         email: $0.email,
                         phone: $0.phone)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.currentUsers = nil
                    self?.userError = error
                    print("error", error)
                }
            } receiveValue: { [weak self] users in
                print("users: - \(users)")
                self?.currentUsers = users
            }
            .store(in: &subscriptions)
    }
}
