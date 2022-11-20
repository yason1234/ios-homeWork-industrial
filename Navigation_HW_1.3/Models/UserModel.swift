//
//  UserModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 19.11.2022.
//

import Foundation
import RealmSwift

final class UserBase: Object {
    @Persisted var users = List<UserModel>()
    @Persisted var IsAuthorized = false
}
    
final class UserModel: Object {
    @Persisted var login = ""
    @Persisted var password = ""
}
        
