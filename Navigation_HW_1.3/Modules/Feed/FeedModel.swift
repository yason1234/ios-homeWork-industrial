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
        case loading
        case loaded(password: String)
    }
    
    enum ViewInput {
        case checkButtonDidTap
        case postButtonDidTap
        case bruteButtonDidTap
    }
    weak var coordinator: FeedCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var bruteForce = BruteForce()
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let secretWord: String = "neto"
    
    func check(word: String) -> Bool {
        return secretWord == word ? true : false
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .checkButtonDidTap:
            print("hi")
        case .postButtonDidTap:
            coordinator?.pushProfileViewController()
        case .bruteButtonDidTap:
            state = .loading
            DispatchQueue.global().async { [weak self] in
                self?.bruteForce(passwordToUnlock: self!.secretWord)
            }
        }
    }
    
    //MARK: brute
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = bruteForce.generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            // Your stuff here
//            print(password)
            // Your stuff here
        }
        state = .loaded(password: password)
        print(password)
    }
}
