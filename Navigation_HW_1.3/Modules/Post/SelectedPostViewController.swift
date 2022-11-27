//
//  SelectedPostViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import UIKit

class SelectedPostViewController: UITableViewController {

    private let viewModel: PostModelProtocol
    private var posts: [Post] {
        get {
            coreDataService.posts
        } set {
            coreDataService.posts = newValue
        }
    }
    private let coreDataService = CoreDataService()
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: PostModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        setupSearchViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.coreDataService.loadPosts()
//            for i in self.posts {
//                self.coreDataService.persistantContainer.viewContext.delete(i)
//                self.coreDataService.saveContext()
//                self.coreDataService.loadPosts()
//            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        cell.author.text = posts[indexPath.row].author
        cell.descriptionLabel.text = posts[indexPath.row].text
        if let dataImage = posts[indexPath.row].image {
            cell.avatarImageView.image = UIImage(named: dataImage)
        }
        cell.likesLabel.text = posts[indexPath.row].likes
        cell.viewsLabel.text = posts[indexPath.row].views

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.updateState(viewInput: .postWillDelete(indexPath, { [weak self] in
                DispatchQueue.main.async {
                    self?.coreDataService.loadPosts()
                    self?.tableView.deleteRows(at: [indexPath], with: .left)
                    //self?.tableView.reloadData()
                }
            }))
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SelectedPostViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    private func setupSearchViewController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        coreDataService.loadPosts(searchText: searchText, context: nil)
        tableView.reloadData()
    }
    
    // лишнее
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        coreDataService.loadPosts()
//        tableView.reloadData()
//    }
}
