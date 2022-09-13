//
//  buttonAlert.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import Foundation
import UIKit

class ButtonAlert: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        setTitle("Alert", for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .systemGreen
        layer.borderWidth = 0.01
        layer.cornerRadius = 25
        translatesAutoresizingMaskIntoConstraints = false
    }
}
