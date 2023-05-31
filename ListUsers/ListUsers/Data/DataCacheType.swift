//
//  DataCacheType.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import Foundation
import RealmSwift

protocol DataCacheType {
    var provider: RealmProviderType { get }
    
    // Object collections
    func addOrUpdate<T: Object>(objects: [T]) -> Bool
    func getAll<T: Object>() -> Results<T>?
}
