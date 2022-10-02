//
//  FeedModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 29.09.2022.
//

import Foundation

class FeedModel {
    
    private let secretWord: String
    
    init(word: String) {
        secretWord = word
    }
    
    func check(word: String) -> Bool {
        return secretWord == word ? true : false
    }
}
