//
//  DetailListCoordinatorView.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import SwiftUI

/// Visual counterpart of the `DetailListCoordinatorView`.
struct DetailListCoordinatorView: View {

    // MARK: Stored Properties
    
    /// Controls the navigation within the `List` flow.
    @ObservedObject var coordinator: DetailListCoordinator

    // MARK: Views

    var body: some View {
        
        // Option1: Bind the stack to the path.
        NavigationStack(path: $coordinator.navigationPath) {
//            UserDetailsView(viewModel: coordinator.viewModel)
//                .handleNavigation(detailsCoordinator: coordinator)
        }
    }
}
