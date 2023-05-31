//
//  DataCache.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import Foundation
import RealmSwift

class DataCache: DataCacheType {
    
    // MARK: - Properties
    
    private(set) var provider: RealmProviderType
    
    // MARK: - Init
    
    required init(provider: RealmProviderType) {
        self.provider = provider
    }
    
    // MARK: - DataCacheType
    
    func addOrUpdate<T: Object>(objects: [T]) -> Bool {
        do {
//            let realm = try Realm(configuration: provider.configuration)
            let realm = try provider.realm()
            
            try realm.write {
                if !(T.primaryKey()?.isEmpty ?? false) {
                    realm.add(objects, update: .all)
                } else {
                    realm.add(objects, update: .error)
                }
            }
            return true
        } catch {
            print("\(error)")
            // logg error to firebase
            
            return false
        }
    }
    
    /**
        Delivers events only on queue with an active runLoop (main by default). If called on
        thread with no active runLoop exception is thrown; (Realm notifications cannot be received since there is no active runLoop)
    */
    func getAll<T: Object>() -> Results<T>? {
        do {
//            let realm = try Realm(configuration: provider.configuration)
            let realm = try provider.realm()
            return realm.objects(T.self)
        } catch {
            print("\(error)")
            // logg error to firebase
            return nil
        }
    }
}

