//
//  FeedCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

final class FeedCoordinator: ModuleCoordinatable {    
    
    let moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        self.module = module
        (module.viewModel as? FeedModel)?.coordinator = self
        return viewController
    }
    
    func pushProfileViewController() {
        let newVC = PostViewController()
        (module?.view as? UINavigationController)?.pushViewController(newVC, animated: true)
    }
}
