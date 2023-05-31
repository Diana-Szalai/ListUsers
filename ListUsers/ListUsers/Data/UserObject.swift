//
//  UserObject.swift
//  ListUsers
//
//  Created by Diana Szalai on 29.05.2023.
//

import SwiftUI
import RealmSwift

class UserObject: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name = ""
    @Persisted var userName = ""
    @Persisted var email = ""
    @Persisted var phone = ""
    
    convenience init(id: Int, name: String, userName: String , email: String, phone: String) {
        self.init()
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.phone = phone
    }
}
