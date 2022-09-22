//
//  LoginInspector.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.09.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
