//
//  myCollectionCell.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 03.08.2022.
//

import UIKit

class myCollectionCell: UICollectionViewCell {
    
    private lazy var photoImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.contentView.addSubview(photoImage)
    }
    
    private func configure() {
        
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleToFill
    }
    
    func setImage(name: String) {
        
        photoImage.image = UIImage(named: name)
    }
}

extension myCollectionCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: self.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
