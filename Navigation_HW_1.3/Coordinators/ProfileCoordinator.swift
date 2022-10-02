//
//  ProfileCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

final class ProfileCoordinator: ModuleCoordinatable {
    
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? ProfileViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushProfileViewController() {
        let newVC = ProfileViewController()
        newVC.setUser(user: Checker.shared.user)
        (module?.view as? UINavigationController)?.pushViewController(newVC, animated: true)
    }
}
