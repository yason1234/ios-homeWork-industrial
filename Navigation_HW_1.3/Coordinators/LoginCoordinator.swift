//
//  ProfileCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

final class LoginCoordinator: ModuleCoordinatable {
    
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
        (module.viewModel as? LoginViewModel)?.coordinator = self
        self.module = module
        
        return viewController
    }
    
    func pushProfileViewController() {
        guard let viewModel = (module?.viewModel as? LoginViewModel) else {return}
        let newVC = ProfileViewController(viewModel: viewModel)
        newVC.setUser(user: Checker.shared.user)
        (module?.view as? UINavigationController)?.pushViewController(newVC, animated: true)
    }
    
    func pushPhotosViewController(image: [String]) {
        let newVC = PhotosViewController()
        newVC.photoArray = image
        (module?.view as? UINavigationController)?.pushViewController(newVC, animated: true)
    }
    
    func addChild(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter{ $0 === coordinator}
    }
}
