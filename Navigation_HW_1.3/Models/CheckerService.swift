//
//  CheckerService.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 12.11.2022.
//
//
import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol: AnyObject {
    func checkCredentials(email: String, password: String, completionError: ((Error) -> (Void))?, completionResult: (() -> Void)? )
    func signUp(email: String, password: String)
}

final class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completionError: ((Error) -> (Void))?, completionResult: (() -> Void)? ) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result != nil {
                completionResult?()
            }
            if let error {
                completionError?(error)
                }
            }
        }
    
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in

        }
    }
}
