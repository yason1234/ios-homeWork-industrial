//
//  LogInViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 29.07.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool
}

class LogInViewController: UIViewController {
    
    private lazy var myScrollView = UIScrollView()
    private lazy var vkImage = UIImageView()
    private lazy var textFieldStackView = UIStackView()
    private lazy var loginTextField = UITextField()
    private lazy var passwordTexfField = UITextField()
    private lazy var loginButton = UIButton(configuration: UIButton.Configuration.filled(), primaryAction: nil)
    
    private var loginDelegate: LoginViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configure()
        setConstraints()
        addActionToButton()
        registerNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerNotification()
    }
    
    private func setupViews() {
        
        view.addSubview(myScrollView)
        myScrollView.addSubview(vkImage)
        myScrollView.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(loginTextField)
        textFieldStackView.addArrangedSubview(passwordTexfField)
        myScrollView.addSubview(loginButton)
        loginTextField.delegate = self
        passwordTexfField.delegate = self
    }
    
    //MARK: setup Delegate
    func setupDelegate(delegate: LoginViewControllerDelegate) {
        loginDelegate = delegate
    }
    
    private func configure() {
        
        myScrollView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        //scroll
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // vkImage
        let image = UIImage(named: "logo")
        vkImage.image = image
        vkImage.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 0
        textFieldStackView.layer.cornerRadius = 10
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // loginTF
        loginTextField.placeholder = "Email or phone"
        loginTextField.layer.borderWidth = 0.5
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.backgroundColor = .systemGray6
        loginTextField.indent(size: 5)
        loginTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        loginTextField.textColor = .black
        loginTextField.font = .systemFont(ofSize: 16)
        loginTextField.autocapitalizationType = .none
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.layer.cornerRadius = 10
        
        // passwordTF
        passwordTexfField.placeholder = "Password"
        passwordTexfField.layer.borderWidth = 0.5
        passwordTexfField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTexfField.layer.cornerRadius = 10
        passwordTexfField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTexfField.isSecureTextEntry = true
        passwordTexfField.backgroundColor = .systemGray6
        passwordTexfField.indent(size: 5)
        passwordTexfField.translatesAutoresizingMaskIntoConstraints = false
        
        // loginButton
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.textColor = .white
        loginButton.backgroundColor = .systemBlue
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.configurationUpdateHandler = { button in
            switch button.state {
            case .normal: button.alpha = 1
            case .selected: button.alpha = 0.8
            case .highlighted: button.alpha = 0.8
            case .disabled: button.alpha = 0.8
            default: button.alpha = 1
            }
        }
    }
}

// MARK: textFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: addTarget
extension LogInViewController {
    
    private func addActionToButton() {
        
        loginButton.addTarget(self, action: #selector(pushToVC), for: .touchUpInside)
    }
    
    @objc private func pushToVC() {
        
        let newVC = ProfileViewController()
        guard let loginText = loginTextField.text, let passText = passwordTexfField.text else { return }
       /*
        #if DEBUG
        let userService = CurrentUserService()
        
        #else
        let userService = CurrentUserService()
        
        #endif
        
        if let user = userService.check(login: loginText, password: passText) {
            navigationController?.pushViewController(newVC, animated: true)
            newVC.setUser(user: user)
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "неверно введен логин или пароль", preferredStyle: .alert)
            let actrion = UIAlertAction(title: "Ok", style: .default) { _ in
                self.loginTextField.becomeFirstResponder()
            }
            
            alertController.addAction(actrion)
            self.present(alertController, animated: true, completion: nil)
        }*/
        
        guard let delegate = loginDelegate else {return}
        if delegate.check(login: loginText, password: passText) {
            navigationController?.pushViewController(newVC, animated: true)
            newVC.setUser(user: Checker.shared.user)
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "неверно введен логин или пароль", preferredStyle: .alert)
            let actrion = UIAlertAction(title: "Ok", style: .default) { _ in
                self.loginTextField.becomeFirstResponder()
            }
            
            alertController.addAction(actrion)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: notificationKeyBoard
extension LogInViewController {
    
    private func registerNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let loginButtonOriginY = loginButton.frame.origin.y + 50
        let kbOriginY = myScrollView.frame.height - kbFrame.height
        let offset = kbOriginY <= loginButtonOriginY ? loginButtonOriginY - kbOriginY + 16 : 0
        myScrollView.contentOffset = CGPoint(x: 0, y: offset)
    }
    
    @objc private func kbWillHide() {
        
        myScrollView.setContentOffset(.zero, animated: true)
    }
}

// MARK: constraints
extension LogInViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            // scroll
            myScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // image
            vkImage.topAnchor.constraint(equalTo: myScrollView.topAnchor, constant: 120),
            vkImage.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor),
            vkImage.widthAnchor.constraint(equalToConstant: 100),
            vkImage.heightAnchor.constraint(equalTo: vkImage.widthAnchor, multiplier: 1),
            
            // textFieldStackView
            textFieldStackView.topAnchor.constraint(equalTo: vkImage.bottomAnchor, constant: 120),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // loginTF
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // passwordTF
            passwordTexfField.heightAnchor.constraint(equalToConstant: 50),
            
            // loginButton
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: extension textField
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
