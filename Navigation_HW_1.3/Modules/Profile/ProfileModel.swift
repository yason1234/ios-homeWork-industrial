//
//  ProfileModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool
}

protocol ProfileModelProtocol: ViewModelProtocol {
    var checkDelegate: LoginViewControllerDelegate? { get set }
    func push()
}

final class ProfileViewModel: ProfileModelProtocol, LoginFactory {
    
    init() {
        setDelegate()
    }
    
    weak var coordinator: ProfileCoordinator?
    var checkDelegate: LoginViewControllerDelegate?
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    func push() {
        coordinator?.pushProfileViewController()
    }
    
    private func setDelegate() {
        
        self.checkDelegate = makeLoginInspector()
    }
}
