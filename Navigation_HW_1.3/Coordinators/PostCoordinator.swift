//
//  PostCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import UIKit

final class PostCoordinator: ModuleCoordinatable {
    
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
        (module.viewModel as? PostViewModel)?.coordinator = self
        return viewController
    }

}

