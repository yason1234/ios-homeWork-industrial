//
//  RealmService.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 19.11.2022.
//

import UIKit
import RealmSwift

final class RealmService {
    
    let realm = try! Realm()
    
    func checkUser(login: String, password: String, vc: UIViewController, completion: (() -> Void)?, completionDeleteText: (() -> Void)?) {
        let newUser = UserModel()
        newUser.login = login
        newUser.password = password

        
        let users = realm.objects(UserModel.self)
        
        if users.contains(where: {$0.login == login}) {
            users.contains { user in
                if user.login == login {
                    if password == user.password {
                        print("check is good, push")
                        completion?()
                    } else {
                        print("incorrect password")
                        presentAlert(vc: vc)
                        completionDeleteText?()
                    }
                }
                return false
            }
        } else {
            print(newUser.login)
            try! realm.write({
                realm.add(newUser)
            })
            completion?()
        }
    }
    
    private func presentAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Incorrect password", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
