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

final class AppFactory {
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .feed:
            let viewModel = FeedModel()
            let view = UINavigationController(rootViewController: FeedViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .profile:
            let viewModel = LoginViewModel()
            let view = UINavigationController(rootViewController: LogInViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }
}
