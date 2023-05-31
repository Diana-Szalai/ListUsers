//
//  ListUsersApp.swift
//  ListUsers
//
//  Created by Diana Szalai on 27.05.2023.
//

import SwiftUI

@main
struct ListUsersApp: App {
    // MARK: Stored Properties

    
    @StateObject var coordinator = HomeCoordinator()

    // MARK: Scenes

    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView(coordinator: coordinator)
        }
    }
//    var body: some Scene {
//        WindowGroup {
//            SearchView(viewModel: SearchViewModel())
//        }
//    }
}
