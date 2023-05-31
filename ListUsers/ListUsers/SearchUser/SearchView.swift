//
//  ContentView.swift
//  ListUsers
//
//  Created by Diana Szalai on 27.05.2023.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    let columns = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        if let users = viewModel.currentUsers {
            VStack(alignment: .center, spacing: 10) {
                Text("My list of users")
                    .bold()
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                            InfoDisplayCell(
                                title: .title("\(user.name)"),
                                subtitle: .title("\(user.userName)"),
                                info: .title(user.phone),
                                verticalSpacing: 8,
                                onTap: {
                                    
                                })
                        }
                    }.padding(.horizontal)
                }.frame(height: 650)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

