//
//  SelectedPostViewController.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import UIKit
import CoreData
import StorageService

class SelectedPostViewController: UITableViewController {

    private let viewModel: PostModelProtocol

    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var fetchController: NSFetchedResultsController = {
        let fetchRequest = Post.fetchRequest()
        fetchRequest.sortDescriptors = []
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.shared.persistantContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    
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
        fetchController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try fetchController.performFetch()
            tableView.reloadData()
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let post = fetchController.object(at: indexPath)
        cell.author.text = post.author
        cell.descriptionLabel.text = post.text
        cell.avatarImageView.image = UIImage(named: post.image!)
        cell.likesLabel.text = post.likes
        cell.viewsLabel.text = post.views
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             viewModel.updateState(viewInput: .postWillDelete(indexPath))
//            CoreDataService.shared.deletePost(atIndexPath: indexPath)
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
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            fetchController.fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", searchText)
            CoreDataService.shared.saveContext()
            try? fetchController.performFetch()
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchController.fetchRequest.predicate = nil
        CoreDataService.shared.saveContext()
        try? fetchController.performFetch()
        tableView.reloadData()
    }
}

extension SelectedPostViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .left)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .bottom)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        @unknown default:
            fatalError()
        }
    }
     
}
