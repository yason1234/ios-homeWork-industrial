//
//  ProfileViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 08.07.2022.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    private lazy var myTableView = UITableView(frame: .zero, style: .grouped)
    private lazy var model: [NewPost] = postArray
    private lazy var image = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "wwdc"]
    private lazy var avatarView = AvatarView()
    private var user: User?


    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        configure()
        setConstraints()
    }

    private func setUpViews() {

        view.addSubview(myTableView)
        view.addSubview(avatarView)
    }

    private func configure() {
        
        #if DEBUG
        
        view.backgroundColor = .white

        #else
        
        view.backgroundColor = .systemBlue
        
        #endif
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.backgroundColor = .white
        myTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "customCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        myTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "collection")
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.backgroundColor = .white
        //avatarView.alpha = 0.5
        avatarView.isHidden = true
    }
    
    //MARK: give image for animation
    func setImage() -> UIImage {
        guard let user = user else {
            return UIImage(named: "person")!
        }
        return user.avatar
    }
    
    func setUser(user: User) {
        self.user = user
    }
}

// MARK: tableView Data and Delegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return model.count
        default: break
        }
        return 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
            cell.configureViews(authorNew: model[indexPath.row].author, avatar: model[indexPath.row].image, description: model[indexPath.row].description, likes: model[indexPath.row].likes, views: model[indexPath.row].views)
            return cell
        } else if indexPath.section == 0 {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "collection", for: indexPath) as?  PhotosTableViewCell else {return UITableViewCell()}
            cell.arrayOfImage = image
            return cell
        }
        return UITableViewCell()

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! ProfileHeaderView
            header.delegate = self
            header.setDelegate()
            header.addAnimation()
            avatarView.setViews(data: header.giveData())
            guard let user = user else { return UIView()}
            header.setupUser(avatar: user.avatar, status: user.status, fullname: user.fullName)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let newVC = PhotosViewController()
            newVC.photoArray = image
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
}

// MARK: constraints
extension ProfileViewController {

    private func setConstraints() {

        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: animation
extension ProfileViewController {
    
    @objc func setAnimation() {
        
        avatarView.isSmall.toggle()
        avatarView.startAnimation()
    }
}

