//
//  FeedViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit

class FeedViewController: UIViewController {

   // private lazy var buttonPost = ButtonFeed()
    var post = Post(title: "Post")
    private lazy var someStackView = UIStackView()
    private lazy var pushPostButton1 = ButtonFeed()
    private lazy var pushPostButton2 = ButtonFeed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraint()
        buttonPress()
        self.tabBarController?.hidesBottomBarWhenPushed = true
        configure()

    }
    
// MARK: setup
    private func setupViews() {
        
        view.backgroundColor = .white
     //   view.addSubview(buttonPost)
        view.addSubview(someStackView)
        someStackView.addSubview(pushPostButton1)
        someStackView.addSubview(pushPostButton2)
    }
    
    private func configure() {
        
        someStackView.spacing = 10
        someStackView.translatesAutoresizingMaskIntoConstraints = false
        
        pushPostButton1.setTitle("Post#2", for: .normal)
        pushPostButton1.backgroundColor = .systemMint
    }
}

// MARK: buttonPress
extension FeedViewController {
    
    private func buttonPress() {
        
        pushPostButton1.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        pushPostButton2.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    @objc private func pushVC() {
        
        let newVC = PostViewController()
        navigationController?.pushViewController(newVC, animated: true)
        newVC.title = post.title
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
}

// MARK: constraints
extension FeedViewController {
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            pushPostButton1.centerXAnchor.constraint(equalTo: someStackView.centerXAnchor),
            pushPostButton1.bottomAnchor.constraint(equalTo: pushPostButton2.topAnchor, constant: -10),
            pushPostButton1.widthAnchor.constraint(equalToConstant: 100),
            pushPostButton1.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([
            pushPostButton2.centerXAnchor.constraint(equalTo: someStackView.centerXAnchor),
            pushPostButton2.centerYAnchor.constraint(equalTo: someStackView.centerYAnchor, constant: 50),
            pushPostButton2.widthAnchor.constraint(equalToConstant: 100),
            pushPostButton2.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([
            someStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someStackView.widthAnchor.constraint(equalToConstant: 100),
            someStackView.heightAnchor.constraint(equalToConstant: 200)])
    }
}

