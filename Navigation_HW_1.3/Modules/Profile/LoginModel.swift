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

protocol LoginModelProtocol: ViewModelProtocol {
    var checkDelegate: LoginViewControllerDelegate? { get set }
    func pushProfileVC()
}

final class LoginViewModel: LoginModelProtocol, LoginFactory {
    
    init() {
        setDelegate()
    }
    
    weak var coordinator: LoginCoordinator?
    var checkDelegate: LoginViewControllerDelegate?
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    func pushProfileVC() {
        coordinator?.pushProfileViewController()
    }
    
    func pushPhotosVC(image: [String]) {
        coordinator?.pushPhotosViewController(image: image)
    }
    
    private func setDelegate() {
        
        self.checkDelegate = makeLoginInspector()
    }
}
