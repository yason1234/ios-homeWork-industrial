//
//  PostViewModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import Foundation

protocol PostModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((PostViewModel.State) -> Void)? { get set }
    func updateState(viewInput: PostViewModel.ViewInput)
}

final class PostViewModel: PostModelProtocol {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case postButtonDidTap
    }
    weak var coordinator: PostCoordinator?
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .postButtonDidTap:
            print("hi")
        }
    }
}
