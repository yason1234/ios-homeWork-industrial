//
//  FeedViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var post = Post(title: "Post")
    private lazy var someStackView = UIStackView()
    private lazy var pushPostButton1 = ButtonFeed()
    private lazy var pushPostButton2 = ButtonFeed()
    private lazy var checkTextField = UITextField()
    private lazy var checkGuessButton = CustomButton(title: "check", titleColor: nil, backColor: .systemBlue, mask: false, action: checkClosure)
    private lazy var checkLabel = UILabel()
   // private lazy var bruteButton = UIButton()
    private lazy var bruteButton = CustomButton(title: "Подобрать пароль", titleColor: nil, backColor: .systemGray, mask: false, action: bruteClosure)
    private lazy var activity = UIActivityIndicatorView()
    
    private var alert: AlertProtocol = Alert()
    
    private let viewModel: FeedModelProtocol
    
    init(viewModel: FeedModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var checkClosure: () -> Void = { [weak self] in
        
        guard let text = self?.checkTextField.text?.lowercased() else {return}
        if !text.isEmpty {
            guard let viewModel = self?.viewModel as? FeedModel else { return }
            self?.checkLabel.backgroundColor = viewModel.check(word: text) ? .systemGreen : .systemRed
            viewModel.check(word: text) ? self?.alert.setAlertController(titleController: "Успешно", message: "Проверка по слову пройдена", titleAction: "ok", VC: self) :
            self?.alert.setAlertController(titleController: "Ошибка", message: "Проверка по слову не пройдена", titleAction: "ok", VC: self)
        } else {
            
            self!.alert.setAlertController(titleController: "Пусто", message: "Необходимо ввести текст", titleAction: "ok", VC: self)
        }
    }
    
    private lazy var bruteClosure: () -> Void = { [weak self] in
        self?.viewModel.updateState(viewInput: .bruteButtonDidTap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraint()
        buttonPress()
        self.tabBarController?.hidesBottomBarWhenPushed = true
        configure()
        bindViewModel()
    }
    
// MARK: bind viewmodel
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("bye")
            case .loading:
                self.activity.startAnimating()
            case .loaded(password: let password):
                DispatchQueue.main.async {
                    self.activity.stopAnimating()
                    self.checkTextField.text = password
                }
            }
        }
    }
    
// MARK: setup
    private func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(someStackView)
        someStackView.addSubview(pushPostButton1)
        someStackView.addSubview(pushPostButton2)
        view.addSubview(checkTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
        view.addSubview(bruteButton)
        view.addSubview(activity)
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
        
       // bruteButton.setTitle("Подобрать пароль", for: .normal)
        //bruteButton.backgroundColor = .systemGray
        bruteButton.layer.borderWidth = 2
        bruteButton.layer.borderColor = UIColor.black.cgColor
        bruteButton.layer.cornerRadius = 10
        bruteButton.clipsToBounds = true
      //  bruteButton.translatesAutoresizingMaskIntoConstraints = false
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .systemBlue
    }
}

// MARK: buttonPress
extension FeedViewController {
    
    private func buttonPress() {
        
        pushPostButton1.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        pushPostButton2.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    @objc private func pushVC() {
        
        viewModel.updateState(viewInput: .postButtonDidTap)
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
            checkLabel.heightAnchor.constraint(equalToConstant: 30),
            
            bruteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bruteButton.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 40),
            bruteButton.widthAnchor.constraint(equalToConstant: 180),
            bruteButton.heightAnchor.constraint(equalToConstant: 50),
            
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 120),
            activity.centerYAnchor.constraint(equalTo: bruteButton.centerYAnchor),
            activity.widthAnchor.constraint(equalToConstant: 30),
            activity.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

