//
//  avatarView.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.08.2022.
//

import UIKit

class AvatarView: UIView {
    
    private lazy var avatarImage = UIImageView(frame: .zero)
    private lazy var reverseAnimationButton = UIButton()
    private lazy var startPoint: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var isSmall: Bool  {
        get {
           return isHidden
        } set {
            isHidden = newValue
        }
    }
    
    private lazy var boolForCornerRaduis: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        stopAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(avatarImage)
        alpha = 0.5
        avatarImage.clipsToBounds = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.backgroundColor = .lightGray
        
        //button
        addSubview(reverseAnimationButton)
        reverseAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        reverseAnimationButton.alpha = 0
        reverseAnimationButton.setBackgroundImage(UIImage(systemName: "clear"), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = boolForCornerRaduis ? avatarImage.frame.width / 2 : 0
    }
    
    lazy var avatarTopConstraint: NSLayoutConstraint = NSLayoutConstraint()
    lazy var avatarLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    lazy var avatarWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    lazy var avatarHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    func setViews(data: (UIImage?, NSLayoutConstraint, NSLayoutConstraint)) {
        
        guard let image = data.0 else {return}
        avatarImage.image = image
        
        avatarTopConstraint = avatarImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: data.1.constant)
        avatarLeadingConstraint = avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: data.2.constant)
        avatarWidthConstraint = avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.24)
        avatarHeightConstraint = avatarImage.heightAnchor.constraint(equalTo: self.avatarImage.widthAnchor)
        
        NSLayoutConstraint.activate([
            
            avatarTopConstraint, avatarLeadingConstraint, avatarWidthConstraint, avatarHeightConstraint,
            
            reverseAnimationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            reverseAnimationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            reverseAnimationButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            reverseAnimationButton.heightAnchor.constraint(equalTo: reverseAnimationButton.widthAnchor)
        ])
    }
    
    func startAnimation() {
        
        startPoint = avatarImage.frame
//        self.avatarWidthConstraint.constant = self.bounds.width
//        self.avatarLeadingConstraint = avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
//        self.avatarTopConstraint = avatarImage.topAnchor.constraint(equalTo: self.topAnchor)
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.625) {
                self.avatarImage.translatesAutoresizingMaskIntoConstraints = true
                self.avatarImage.center = CGPoint(x: self.center.x, y: self.center.y - (self.safeAreaLayoutGuide.owningView?.frame.origin.y)!)
                self.avatarImage.bounds.size.width = self.bounds.size.width
                self.avatarImage.bounds.size.height = self.bounds.size.width
                self.boolForCornerRaduis.toggle()
                self.alpha = 1

                self.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.375) {
                self.reverseAnimationButton.alpha = 1
            }
        } 
    }
    
    func stopAnimation() {
        
        self.reverseAnimationButton.addTarget(self, action: #selector(reverseAnimation), for: .touchUpInside)

    }
    
    @objc private func reverseAnimation() {
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .calculationModeCubic) {
            UIView.animateKeyframes(withDuration: 0.8,
                                    delay: 0,
                                    options: .calculationModeCubic) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.625) {
                    self.avatarImage.translatesAutoresizingMaskIntoConstraints = true
                    self.avatarImage.frame = self.startPoint
                    self.boolForCornerRaduis.toggle()
                    self.alpha = 0

                    self.layoutIfNeeded()
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.625, relativeDuration: 0.375) {
                    self.reverseAnimationButton.alpha = 0
                }
            } completion: { _ in
                self.isSmall.toggle()
            }
        }
    }
}
