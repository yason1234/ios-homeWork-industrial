//
//  ProfileHeaderView.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 12.07.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private lazy var avatarImageView = UIImageView()
    private lazy var fullNameLabel = UILabel()
    private lazy var statusLabel = UILabel()
    private lazy var setStatusButton = UIButton()
    private lazy var statusTextField = UITextField()
    private var statusText: String?
    
    weak var delegate: ProfileViewController?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        allFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    func allFunc() {
        
        setupViews()
        setConstraints()
        configureViews()
        actionStatusButton()
        statusTexfFieldAction()
    }

     func setupViews() {

         addSubview(avatarImageView)
         addSubview(fullNameLabel)
         addSubview(statusLabel)
         addSubview(setStatusButton)
         addSubview(statusTextField)
    }
    
     func configureViews() {
        
        // UIimage
         avatarImageView.image = UIImage(named: "Michel_Muller")
         avatarImageView.clipsToBounds = true
         avatarImageView.layer.borderWidth = 3
         avatarImageView.layer.borderColor = UIColor.white.cgColor
         avatarImageView.backgroundColor = .lightGray
         avatarImageView.translatesAutoresizingMaskIntoConstraints = false
            
            // headLabel
         fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
         fullNameLabel.textColor = .black
         fullNameLabel.text = "Momo"
         fullNameLabel.textAlignment = .center
         fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // statusLabel
         statusLabel.text = "Waiting for something..."
         statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
         statusLabel.textColor = .gray
         statusLabel.textAlignment = .center
         statusLabel.numberOfLines = 0
         statusLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // statusButton
         setStatusButton.setTitle("Show status", for: .normal)
         setStatusButton.backgroundColor = .systemBlue
         setStatusButton.tintColor = .white
         setStatusButton.layer.cornerRadius = 15
         setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
         setStatusButton.layer.shadowRadius = 4
         setStatusButton.layer.shadowColor = UIColor.black.cgColor
         setStatusButton.layer.shadowOpacity = 0.7
         setStatusButton.translatesAutoresizingMaskIntoConstraints = false
         
            // status textField
         statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
         statusTextField.textColor = .black
         statusTextField.layer.borderWidth = 1
         statusTextField.layer.cornerRadius = 12
         statusTextField.layer.borderColor = UIColor.black.cgColor
         statusTextField.backgroundColor = .white
         statusTextField.translatesAutoresizingMaskIntoConstraints = false
         statusTextField.clipsToBounds = true
         statusTextField.textAlignment = .natural
         statusTextField.borderStyle = .roundedRect
    }
    
    func setDelegate() {
        statusTextField.delegate = delegate
    }
    
    func giveData() -> (UIImage, NSLayoutConstraint, NSLayoutConstraint) {

        return (avatarImageView.image!, avatarTopConstraint, avatarLeadingConstraint)
    }
    
    var avatarTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var avatarLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var avatarWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var avatarHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
}

extension ProfileHeaderView {

     func setConstraints() {
         
         avatarTopConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
         avatarLeadingConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
         avatarWidthConstraint = self.avatarImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.24)
         avatarHeightConstraint =  self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor)

        NSLayoutConstraint.activate([
//            self.avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            self.avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            self.avatarImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.24),
//            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor),
            
            avatarTopConstraint,
            avatarLeadingConstraint,
            avatarWidthConstraint,
            avatarHeightConstraint,
         
             self.fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
             self.fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         
            self.statusLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 10),
            self.statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30),

            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 10),
            self.setStatusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.setStatusButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 40),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
          
            self.statusTextField.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 10),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            self.statusTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 30)])
         
    }
}

// button action

extension ProfileHeaderView {
    
    func actionStatusButton() {
        
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        
        statusLabel.text = statusText
    }
    
    func statusTexfFieldAction() {
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc func statusTextChanged() {
        
        statusText = statusTextField.text
    }
}

// MARK: animation
extension ProfileHeaderView {
    
    func addAnimation() {
        
        let gesture = UITapGestureRecognizer(target: delegate, action: #selector(delegate?.setAnimation))
        
        avatarImageView.addGestureRecognizer(gesture)
        avatarImageView.isUserInteractionEnabled = true
    }
}
