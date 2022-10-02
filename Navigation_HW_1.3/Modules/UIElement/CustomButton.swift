//
//  CustomButton.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 28.09.2022.
//

import UIKit

class CustomButton: UIButton {
    
    private let title: String?
    private let titleColor: UIColor?
    private let backColor: UIColor?
    private let actionClosure: () -> Void
    
    init(title: String?,
         titleColor: UIColor?,
         backColor: UIColor?,
         mask: Bool,
         action: @escaping () -> Void) {
        
        self.title = title
        self.titleColor = titleColor
        self.backColor = backColor
        self.actionClosure = action
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        configure()
        translatesAutoresizingMaskIntoConstraints = mask
        addActionToButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backColor
    }
    
    private func addActionToButton() {
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        
        actionClosure()
    }
}
