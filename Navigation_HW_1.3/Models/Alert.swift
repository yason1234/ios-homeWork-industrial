//
//  Alert.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 02.10.2022.
//

import UIKit

protocol AlertProtocol {
    
    func setAlertController(titleController: String, message: String, titleAction: String, VC: UIViewController?)
}
struct Alert: AlertProtocol {
    
    func setAlertController(titleController: String, message: String, titleAction: String, VC: UIViewController?) {
        let alertController = UIAlertController(title: titleController, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .default)
        
        alertController.addAction(action)
        VC?.present(alertController, animated: true, completion: nil)
    }
}
