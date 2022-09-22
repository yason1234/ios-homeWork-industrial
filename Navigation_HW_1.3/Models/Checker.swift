//
//  Checher.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.09.2022.
//

import UIKit

final class Checker {
    
    static let shared = Checker()
    
    private let login = "qwerty"
    private let password = "kerk1234"
    let user = User(login: "qwerty", fullName: "Dima", avatar: UIImage(named: "bmw")!, status: "Hi guys")
    
    func check(login: String, password: String) -> Bool {
        
        return self.login == login && self.password == password ? true : false
    }
}

