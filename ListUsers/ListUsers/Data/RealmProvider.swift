//
//  RealmProvider.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import Foundation
import RealmSwift


struct RealmProvider: RealmProviderType {
    
    let configuration: Realm.Configuration
    
    static let realmParentDirName = "realm"
    static let usersRealmFileName = "users"
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    func realm() throws -> Realm {
        return try Realm(configuration: configuration)
    }
    
    // MARK: - Users realm
    
    static var usersConfig: Realm.Configuration {
        do {
            let documentsURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let configURL = documentsURL
//                .appendingPathComponent(realmParentDirName, isDirectory: true)
                .appendingPathComponent(usersRealmFileName, isDirectory: false)
            
            return Realm.Configuration(fileURL: configURL,
                                       objectTypes: [UserObject.self]) // TODO: specify an array of realm "Object" to improve realm                     // opening performance
            
        } catch let err {
            fatalError("Failed finding expected path: \(err)")
        }
    }
    
    // MARK: - Util
    
    var fileURL: URL? {
        return configuration.fileURL
    }
    
    var dirURL: URL? {
        return configuration.fileURL?.deletingLastPathComponent()
    }
    
    var parentDirUrl: URL? {
        let parentDirUrl = configuration.fileURL?.deletingLastPathComponent().deletingLastPathComponent()
        print("realm parent dir: \(String(describing: parentDirUrl))")
        return configuration.fileURL?.deletingLastPathComponent().deletingLastPathComponent()
    }
    
    var fileExists: Bool {
        guard let fileURL = configuration.fileURL else { return false }
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// Each realm file is saved in its' own dir using 'userId' (ex: Documents/userId/userId.realm)
    /// for autoInvoice orgNumber is used instead of userId
    var realmDirExists: Bool {
        guard let url = dirURL else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    var parentRealmDirExists: Bool {
        guard let url = parentDirUrl else { return false }
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    /// Delete existing Realm files/folders
    
    func removeFiles() throws {
        guard let fileUrl = configuration.fileURL,
            let files = FileManager.default.enumerator(at: fileUrl.deletingLastPathComponent(), includingPropertiesForKeys: []),
            let fileName = fileUrl.lastPathComponent.components(separatedBy: ".").first else {
                return
        }
        
        for file in files.allObjects {
            guard let url = file as? URL,
                url.lastPathComponent.hasPrefix("\(fileName).") else { continue }
            try FileManager.default.removeItem(at: url)
        }
    }
}
