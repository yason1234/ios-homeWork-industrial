//
//  ProfileViewCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 03.10.2022.
//

import UIKit

final class ProfileCoordinator: ModuleCoordinatable {
    
    var moduleType: Module.ModuleType
    
    private let factory: AppFactory
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    private(set) var childCoordinators: [Coordinatable] = []
    private(set) var module: Module?
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let view = module.view
        self.module = module
        (module.viewModel as? ProfileViewModel)?.coordinator = self
        return view
    }
    
    func pushToVC(image: [String]) {
        
        let newVC = PhotosViewController()
        newVC.photoArray = image
        (module?.view as? UINavigationController)?.pushViewController(newVC, animated: true)
    }
}
