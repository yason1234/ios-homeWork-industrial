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
    private lazy var checkTextField = UITextField()
    private lazy var checkGuessButton = CustomButton(title: "check", titleColor: nil, backColor: .systemBlue, mask: false, action: closure)
    private lazy var checkLabel = UILabel()
    private lazy var feedModel = FeedModel(word: "netologia")
    
    private lazy var closure: () -> Void = { [weak self] in
        
        guard let text = self?.checkTextField.text?.lowercased() else {return}
        if !text.isEmpty {
       
            self?.checkLabel.backgroundColor = self!.feedModel.check(word: text) ? .systemGreen : .systemRed
            self!.feedModel.check(word: text) ? self?.feedModel.setAlertController(titleController: "Успешно", message: "Проверка по слову пройдена", titleAction: "ok", VC: self) :
            self?.feedModel.setAlertController(titleController: "Ошибка", message: "Проверка по слову не пройдена", titleAction: "ok", VC: self)
        } else {
            
            self!.feedModel.setAlertController(titleController: "Пусто", message: "Необходимо ввести текст", titleAction: "ok", VC: self)
        }
    }
    
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
        view.addSubview(checkTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
    }
    
    private func configure() {
        
        someStackView.spacing = 10
        someStackView.translatesAutoresizingMaskIntoConstraints = false
        
        pushPostButton1.setTitle("Post#2", for: .normal)
        pushPostButton1.backgroundColor = .systemMint
        
        checkTextField.translatesAutoresizingMaskIntoConstraints = false
        checkTextField.becomeFirstResponder()
        
        checkGuessButton.layer.borderWidth = 2
        checkGuessButton.layer.borderColor = UIColor.black.cgColor
        checkGuessButton.layer.cornerRadius = 10
        checkGuessButton.clipsToBounds = true
        
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.tintColor = .black
        checkLabel.layer.borderWidth = 2
        checkLabel.layer.borderColor = UIColor.black.cgColor
        checkLabel.layer.cornerRadius = 10
        checkLabel.clipsToBounds = true
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
            pushPostButton1.heightAnchor.constraint(equalToConstant: 50),
        
            pushPostButton2.centerXAnchor.constraint(equalTo: someStackView.centerXAnchor),
            pushPostButton2.centerYAnchor.constraint(equalTo: someStackView.centerYAnchor, constant: 50),
            pushPostButton2.widthAnchor.constraint(equalToConstant: 100),
            pushPostButton2.heightAnchor.constraint(equalToConstant: 50),
        
            someStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someStackView.widthAnchor.constraint(equalToConstant: 100),
            someStackView.heightAnchor.constraint(equalToConstant: 200),
        
            checkTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            checkTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5),
            checkTextField.heightAnchor.constraint(equalToConstant: 20),

            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: checkTextField.bottomAnchor, constant: 20),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 80),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 30),
            
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
            checkLabel.widthAnchor.constraint(equalToConstant: 80),
            checkLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

