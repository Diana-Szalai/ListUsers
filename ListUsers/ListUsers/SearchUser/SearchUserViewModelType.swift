//
//  SearchUserViewModel.swift
//  ListUsers
//
//  Created by Diana Szalai on 28.05.2023.
//

import Foundation

protocol SearchUserViewModelType: ObservableObject {

    var currentUsers: [User]? { get }
    func getCurrentUsers()
}
