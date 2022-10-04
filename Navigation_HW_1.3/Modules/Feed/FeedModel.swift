//
//  FeedModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import Foundation

protocol FeedModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((FeedModel.State) -> Void)? {get set}
    func updateState(viewInput: FeedModel.ViewInput)
}
final class FeedModel: FeedModelProtocol {
    
    enum State {
        case initial
    }
    
    enum ViewInput {
        case checkButtonDidTap
        case postButtonDidTap
    }
    weak var coordinator: FeedCoordinator?
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let secretWord: String = "netologia"
    
    func check(word: String) -> Bool {
        return secretWord == word ? true : false
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .checkButtonDidTap:
            print("hi")
        case .postButtonDidTap:
            coordinator?.pushProfileViewController()
        }
    }
}
