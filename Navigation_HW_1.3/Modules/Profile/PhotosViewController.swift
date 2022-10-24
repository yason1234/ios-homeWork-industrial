//
//  CollectionViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 04.08.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var photosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    lazy var photoArray = [String]()
    private lazy var arrayForFacade = [UIImage]()
    lazy var imageArray = [UIImage]()
    private lazy var imageFacade = ImagePublisherFacade()
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        configure()
        setConstraints()
        CheckTimeProcessor()
       // imageFacade.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        //imageFacade.removeSubscription(for: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupViews() {
        
        view.addSubview(photosCollectionView)
    }
    
    private func setupArray() {
        
        photoArray.forEach { photo in
            self.arrayForFacade.append(UIImage(named: photo)!)
        }
        //imageFacade.addImagesWithTimer(time: 1, repeat: 21, userImages: arrayForFacade)
    }
    
    private func configureImages() {
        let imageProcessor = ImageProcessor()
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(sourceImages: arrayForFacade, filter: .chrome, qos: .utility) { [weak self] imageCG in
            var count = 0
            DispatchQueue.main.async { [weak self] in
                self?.timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                    
                    self?.imageArray.append(UIImage(cgImage: imageCG[count]!))
                    self?.photosCollectionView.reloadData()
                    
                    count += 1
                    
                    if count == imageCG.count {
                        timer.invalidate()
                    }
                }
            }
//            DispatchQueue.main.async {
//                self?.imageArray = imageCG.map({ imageCG in
//                    UIImage(cgImage: imageCG!)
//                })
//                self?.photosCollectionView.reloadData()
//            }
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            print(nanoTime)
        }
    }
    
    @objc private func add() {
        
    }
    
    private func CheckTimeProcessor() {
        setupArray()
//        let start = DispatchTime.now()
        configureImages()
//        let end = DispatchTime.now()
//        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
//        print(nanoTime)
    }
    
    private func configure() {
        
        navigationItem.title = "Photo Gallery"
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        photosCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
}

//MARK: collection Delegate and Datasource

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
//        arrayForFacade.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCollectionViewCell else {return UICollectionViewCell()}
       // cell.setImage(name: photoArray[indexPath.row])
        cell.setImage(image: imageArray[indexPath.row])
//        cell.setImage(image: arrayForFacade[indexPath.row])
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 8 - 8 - 8 - 8
        let height = width
        return CGSize(width: width / 3, height: height / 3)
    }
    
}

extension PhotosViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        
        imageArray = images

        photosCollectionView.reloadData()
    }
    
}
