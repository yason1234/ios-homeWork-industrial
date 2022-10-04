//
//  ProfileModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 03.10.2022.
//

import UIKit

protocol ProfileModelProtocol: ViewModelProtocol {
    func pushToNewVC(image: [String])
}

final class ProfileViewModel: ProfileModelProtocol {
   
    weak var coordinator: ProfileCoordinator?
    
    func pushToNewVC(image: [String]) {
        coordinator?.pushToVC(image: image)
    }
}
