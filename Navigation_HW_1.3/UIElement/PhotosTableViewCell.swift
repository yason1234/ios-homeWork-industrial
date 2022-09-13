//
//  PhotosTableViewCell.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 03.08.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photoLabel = UILabel()
    private lazy var arrowToNextVC = UIImageView()
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private lazy var container = UIView()
    var arrayOfImage: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configure()
        setConstraints()
       
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionView.register(myCollectionCell.self, forCellWithReuseIdentifier: "cell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
       // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.contentView.addSubview(photoLabel)
        container.addSubview(photosCollectionView)
        self.contentView.addSubview(container)
        self.contentView.addSubview(arrowToNextVC)
    }
    
    private func configure() {
        
        // label
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        photoLabel.text = "Photos"
        photoLabel.textColor = .black
        photoLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        //arrow
        arrowToNextVC.image = UIImage(systemName: "arrow.right")
        arrowToNextVC.translatesAutoresizingMaskIntoConstraints = false
        
        // collection
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.clipsToBounds = true
        
        // container
        container.translatesAutoresizingMaskIntoConstraints = false
    }
   
}

extension PhotosTableViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowToNextVC.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrowToNextVC.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            container.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            container.heightAnchor.constraint(equalToConstant: self.frame.width / 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            photosCollectionView.topAnchor.constraint(equalTo: container.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myCollectionCell else {return UICollectionViewCell()}
        cell.setImage(name: arrayOfImage[indexPath.row])
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 12 - 12 - 8 * 3
        return CGSize(width: width / 4, height: width / 4)
        //return CGSize(width: UIScreen.main.bounds.width / 4 - 12, height: UIScreen.main.bounds.width / 4 - 12)
    }
}
