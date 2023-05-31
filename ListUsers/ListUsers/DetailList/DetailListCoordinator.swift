//
//  DetailListCoordinator.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation
import SwiftUI

/// Stable identifier of the routes that are accessible in the `RecipeRoute` feature flow.
enum Route: Hashable {
    
    /// Details page of an item in which more details are visible and rating page.
    case details(user: User)
}

class DetailListCoordinator: ObservableObject, Identifiable {

    // MARK: Stored Properties
    @Published var userDetailsViewModel: UserDetailsViewModel

    /// 2 way binding for the `NavigationStack`.
    @Published var navigationPath: NavigationPath = NavigationPath()
    
    let userService: UserService

    // MARK: Initialization

    init(title: String,
         userService: UserService) {
       
        self.userService = userService
        self.userDetailsViewModel = .init()
    }

    // MARK: - DetailListCoordinator implementation.
    
    func goToUserDetails(_ user: User) {
        navigationPath.append(Route.details(user: user))}
}
