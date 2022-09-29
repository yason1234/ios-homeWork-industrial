//
//  FeedModel.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 29.09.2022.
//

import Foundation
import UIKit

class FeedModel {
    
    private let secretWord: String
    
    init(word: String) {
        
        secretWord = word
    }
    
    func check(word: String) -> Bool {
        
        return secretWord == word ? true : false
    }
    
    func setAlertController(titleController: String, message: String, titleAction: String, VC: UIViewController?) {
        
        let alertController = UIAlertController(title: titleController, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .default)
        
        alertController.addAction(action)
        VC?.present(alertController, animated: true, completion: nil)
    }
}
