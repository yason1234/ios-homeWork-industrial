//
//  FeedModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import Foundation

protocol FeedModelProtocol: ViewModelProtocol {
    
    func push()
}
final class FeedModel1: FeedModelProtocol {
    
    weak var coordinator: FeedCoordinator?
    
    func push() {
        
        coordinator?.pushProfileViewController()
    }
}
