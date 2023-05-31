//
//  HomeCoordinatorView.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import SwiftUI

struct HomeCoordinatorView: View {
    
    // MARK: Stored Properties
    
    @ObservedObject var coordinator: HomeCoordinator
    @Environment(\.horizontalSizeClass) var sizeClass
    
    // MARK: Views
    
    var body: some View {
        switch sizeClass  {
        case .compact:
            TabView(selection: $coordinator.tab) {
                if let searchViewModel = coordinator.searchViewModel {
                    SearchView(viewModel: searchViewModel)
                        .tabItem {
                            VStack {
                                Text("Home")
                                Image.homeImageMultiColor
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.green)
                            }
                        }.tag(HomeTab.home)
                }
            }
        default:
            EmptyView()
//            SplitViewCoordinator(coordinator: coordinator)
        }
    }
}

public extension Image {
    
    // MARK: - TabBar
    
    static let homeImage = Image(systemName: "house")
    static let homeImageMultiColor = Image(systemName: "house.fill")
}
