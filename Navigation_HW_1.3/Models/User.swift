//
//  User.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 20.09.2022.
//

import UIKit

protocol UserService {
    
    func check(login: String, password: String) -> User?
}

final class User {
    
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        
        self.login = login; self.fullName = fullName; self.avatar = avatar; self.status = status
    }
}

final class CurrentUserService: UserService {
    
    var user: User?
    
    func check(login: String, password: String) -> User? {
       
        for user in users {
            print(user.login)
            if user.login == login {
                return user
            }
        }
        return nil
    }
}

final class TestUserService: UserService {
   
    private lazy var user = User(login: "Wa5ili4", fullName: "Kirill", avatar: UIImage(named: "jordan")!, status: "child")
    
    func check(login: String, password: String) -> User? {
        if user.login == login {
            return user
        }
        return nil
    }
    
    
    
}
