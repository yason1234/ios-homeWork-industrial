//
//  PostViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addNavBar()
    }
    
    private func addNavBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(navBarPush))
    }
    
    @objc private func navBarPush() {
        
//        let newVC = InfoViewController()
//        navigationController?.present(newVC, animated: true, completion: nil)
    }
}
