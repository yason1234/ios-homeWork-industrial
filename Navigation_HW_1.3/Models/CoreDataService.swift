//
//  CoreDataService.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import UIKit
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    // MARK: CoreData stack
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var posts = [Post]()
    
    func loadPosts() {
        let request = Post.fetchRequest()
        do {
            posts = try persistantContainer.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createPost(cell: PostTableViewCell) {

        if !posts.isEmpty {
            if !posts.contains(where: {$0.title == cell.author.text}) {
                let newPosts = Post(context: persistantContainer.viewContext)
                newPosts.text = cell.descriptionLabel.text
                newPosts.title = cell.author.text
                guard let image = cell.avatarImageView.image?.pngData() else {return}
                newPosts.image = image
                newPosts.likes = cell.likesLabel.text
                newPosts.views = cell.viewsLabel.text
                saveContext()
                loadPosts()
            } else {
                print("Post have been created")
            }
        } else {
            let newPosts = Post(context: persistantContainer.viewContext)
            newPosts.text = cell.descriptionLabel.text
            newPosts.title = cell.author.text
            guard let image = cell.avatarImageView.image?.pngData() else {return}
            newPosts.image = image
            newPosts.likes = cell.likesLabel.text
            newPosts.views = cell.viewsLabel.text
            saveContext()
            loadPosts()
        }
    }
}
