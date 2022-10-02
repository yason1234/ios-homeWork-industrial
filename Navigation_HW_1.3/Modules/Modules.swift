//
//  Modules.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum ModuleType {
        case feed
        case profile
    }

    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}

extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .feed:
            return UITabBarItem(title: "feed", image: UIImage(systemName: "creditcard"), tag: 0)
        case .profile:
            return UITabBarItem(title: "profile", image: UIImage(systemName: "bag"), tag: 1)
        }
    }
}
