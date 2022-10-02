//
//  Coordinatable.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

protocol Coordinatable: AnyObject {
    
    var childCoordinators: [Coordinatable] { get }
    func start() -> UIViewController
    func addChild(_ coordinator: Coordinatable)
    func removeChild(_ coordinator: Coordinatable)
}

protocol ModuleCoordinatable: Coordinatable {
    var module: Module? { get }
    var moduleType: Module.ModuleType { get }
}

extension Coordinatable {
    
    func addChild(_ coordinator: Coordinatable) {}
    func removeChild(_ coordinator: Coordinatable) {}
}

