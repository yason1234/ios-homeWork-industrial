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
    var onStateDidChange: ((LoginViewModel.State) -> Void)? { get set }
    func updateState(viewInput: LoginViewModel.ViewInput)
    var checkDelegate: LoginViewControllerDelegate? { get set }
}

final class LoginViewModel: LoginModelProtocol, LoginFactory {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case loginButtonDidTap
        case arrowDidTap([String])
    }
    
    init() {
        setDelegate()
    }
    
    weak var coordinator: LoginCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var checkDelegate: LoginViewControllerDelegate?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
    private func setDelegate() {
        
        self.checkDelegate = makeLoginInspector()
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .loginButtonDidTap:
            coordinator?.pushProfileViewController()
        case .arrowDidTap(let image):
            coordinator?.pushPhotosViewController(image: image)
        }
    }
}