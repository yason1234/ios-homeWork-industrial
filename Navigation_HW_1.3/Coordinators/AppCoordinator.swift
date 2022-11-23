//
//  AppCoordinator.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    private(set) var childCoordinators: [Coordinatable] = []
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator(moduleType: .feed, factory: factory)
        let profileCoordinator = LoginCoordinator(moduleType: .profile, factory: factory)
        let postCoordinator = PostCoordinator(moduleType: .post, factory: factory)
        
        let appTabBar = AppTabBarController(viewControllers: [feedCoordinator.start(),
                                                              profileCoordinator.start(),
                                                              postCoordinator.start()])
        
        addChild(feedCoordinator)
        addChild(profileCoordinator)
        addChild(postCoordinator)
        
        return appTabBar
    }

    func addChild(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter{ $0 === coordinator}
    }
}

