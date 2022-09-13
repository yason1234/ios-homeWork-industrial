//
//  InfoViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var buttonAlert = ButtonAlert()
    private lazy var dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        view.addSubview(buttonAlert)
        view.addSubview(dismissButton)
        setConstraint()
        presentAlert()
        configure()
        dismiss()
    }
    
    private func configure() {
        
        dismissButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dismissButton.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        dismissButton.tintColor = .black
        
    }
    
    func dismiss() {
        
        dismissButton.addTarget(self, action: #selector(pressDismiss), for: .touchUpInside)
    }
    
    @objc func pressDismiss() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: buttonAlert
extension InfoViewController {
    
    private func presentAlert() {
        
        buttonAlert.addTarget(self, action: #selector(alert), for: .touchUpInside)
    }
    
    @objc private func alert() {
        
        let alertController = UIAlertController(title: "Add info", message: "write some text", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else { return }
            print(text)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: constraint
extension InfoViewController {
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            buttonAlert.widthAnchor.constraint(equalToConstant: 100),
            buttonAlert.heightAnchor.constraint(equalToConstant: 50)])
    }
}
