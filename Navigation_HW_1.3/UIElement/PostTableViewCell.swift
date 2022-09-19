//
//  PostTableViewCell.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 31.07.2022.
//

import UIKit
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    var author = UILabel()
    var avatarImageView = UIImageView()
    var descriptionLabel = UILabel()
    var likesLabel = UILabel()
    var viewsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        author.text = nil
        avatarImageView.image = nil
        descriptionLabel.text = nil
        likesLabel.text = nil
        viewsLabel.text = nil
    }
    
    private func setupViews() {
        
        self.addSubview(author)
        self.addSubview(avatarImageView)
        self.addSubview(descriptionLabel)
        self.addSubview(likesLabel)
        self.addSubview(viewsLabel)
    }
    
    private func configure() {
    
        //header
        author.font = .systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 2
        author.textAlignment = .left
        author.translatesAutoresizingMaskIntoConstraints = false
        
        //image
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = .black
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //description
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // likes and views
        likesLabel.font = .systemFont(ofSize: 16)
        likesLabel.textColor = .black
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        viewsLabel.font = .systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            author.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            avatarImageView.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    func configureViews(authorNew: String, avatar: String, description: String, likes: Int, views: Int) {
        author.text = authorNew

        guard let avatarImage = UIImage(named: avatar) else {return}
        let process = ImageProcessor()
        
//        process.processImage(sourceImage: avatarImage, filter: .colorInvert) { imageNew in
//            avatarImageView.image = imageNew
//        }
        
        process.processImageAsync(sourceImage: avatarImage, filter: .process) { image in
            DispatchQueue.main.async {
                let imageNew = UIImage(cgImage: image!)
                self.avatarImageView.image = imageNew
            }
        }
        descriptionLabel.text = description
        likesLabel.text = "Likes: \(likes)"
        viewsLabel.text = "Views: \(views)"
    }
}
