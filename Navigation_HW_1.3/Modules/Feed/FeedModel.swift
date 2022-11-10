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
    func loadJson(completion: ((String?, [String]?) -> Void)?, _ type: FeedModel.TypeParse)
}

final class FeedModel: FeedModelProtocol {
    
    enum State {
        case initial(String?, String?, [String]?)
        case loading
        case loaded(password: String)
    }
    
    enum ViewInput {
        case initial
        case checkButtonDidTap
        case postButtonDidTap
        case bruteButtonDidTap
    }
    
    enum TypeParse {
        case serilization
        case codable
    }
    weak var coordinator: FeedCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var bruteForce = BruteForce()
    let jsonModel = NetworkJson()
    let jsonCodableModel = NetworkJSONCodable()
    
    private(set) var state: State = .initial(nil, nil, nil) {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let secretWord: String = "net"
    
    func check(word: String) -> Bool {
        return secretWord == word ? true : false
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .initial:
            loadJson(completion: { [weak self] title, resident in
                self?.loadJson(completion: { [weak self] titleCodable, resident1 in
                    print(resident1)
                    self?.state = .initial(title, titleCodable, resident1)
                }, .codable)
            }, .serilization)
        case .checkButtonDidTap:
            print("hi")
        case .postButtonDidTap:
            coordinator?.pushProfileViewController()
        case .bruteButtonDidTap:
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
    
    //MARK: JSON
    func loadJson(completion: ((String?, [String]?) -> Void)?, _ type:  TypeParse) {
        switch type {
        case .serilization:
            jsonModel.jsonRequest { title in
                completion?(title, nil)
            }
        case .codable:
            jsonCodableModel.parsingPlanet { title, residents in
                completion?(title, residents)
            }
        }
    }
}
