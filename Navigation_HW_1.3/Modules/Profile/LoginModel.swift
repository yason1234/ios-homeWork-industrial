//
//  ProfileModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit
import RealmSwift
import CoreData

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
    var checker: CheckerServiceProtocol { get set }
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
        case loginButtonToAuthDidTap(String, String, UIViewController, (() -> Void)?)
        case postDidTap(PostTableViewCell)
    }
    
    init() {
        setDelegate()
    }
    
    weak var coordinator: LoginCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var checkDelegate: LoginViewControllerDelegate?
    private let checker = RealmService()
    private let coreDataService = CoreDataService.shared
    
    
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
        case .loginButtonToAuthDidTap(let login, let password, let vc, let completion):
            checker.checkUser(login: login, password: password, vc: vc) { [weak self] in
                self?.coordinator?.pushProfileViewController()
            } completionDeleteText: { completion?() }
        case .postDidTap(let cell):
            coreDataService.createPost(cell: cell)
        }
    }
}
