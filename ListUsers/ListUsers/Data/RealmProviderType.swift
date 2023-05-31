//
//  RealmProviderType.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import Foundation
import RealmSwift

protocol RealmProviderType {
    var configuration: Realm.Configuration { get }
    
    init(configuration: Realm.Configuration)
    
    func realm() throws -> Realm
    
    var fileURL: URL? { get }
    var dirURL: URL? { get }
    var parentDirUrl: URL? { get }
    
    var fileExists: Bool { get }
    var realmDirExists: Bool { get }
    var parentRealmDirExists: Bool { get }
}
