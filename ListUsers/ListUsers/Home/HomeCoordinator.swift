//
//  HomeCoordinator.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation
import SwiftUI

enum HomeTab: Hashable {
    case home
}

enum HomeDestination: Hashable {
    case detailPage
}

enum AppCategory: Hashable {
    case home(_ : HomeDestination)
    case none
}

class HomeCoordinator: ObservableObject {
    
    // MARK: Stored Properties
    @Published var tab = HomeTab.home
    @Published var category: AppCategory? = nil
    @Published var searchViewModel: SearchViewModel?
    
    // MARK: Chield Coordinators
    @Published var detailListCoordinator: DetailListCoordinator?
    @Published var navigationPath: NavigationPath = .init()
    
//    private var userService: UserService
    
    // MARK: Initialization
    init() {
        let usersService = UserService()
        let realmusersConfig = RealmProvider.usersConfig
        let realmProvider = RealmProvider(configuration: realmusersConfig)
        
        let usersRepository = UsersRepository(usersService: usersService,
                                              realmProvider: realmProvider)
        
        self.searchViewModel = SearchViewModel(usersRepository: usersRepository)
//        self.detailListCoordinator = .init(title: "DetailListCoordinator",
//                                           userService: userService)
    }

    // MARK: Methods
    
    func setCategory(_ update: AppCategory) {
        category = update
    }
    
}
