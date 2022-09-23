//
//  LoginInspector.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.09.2022.
//

import Foundation
import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    func returnLoginVC() -> UIViewController {
        let loginVC = LogInViewController()
        loginVC.setupDelegate(delegate: makeLoginInspector())
        return loginVC
    }
}
