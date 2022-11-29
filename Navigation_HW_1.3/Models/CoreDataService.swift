//
//  CoreDataService.swift
//  Navigation_HW_1.3
//
//  Created by Dima Shikhalev on 22.11.2022.
//

import UIKit
import CoreData
import StorageService

final class CoreDataService {
    
    
    // MARK: CoreData stack
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
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
    
    func loadPosts(searchText: String? = nil ,context: NSManagedObjectContext? = nil) {
        let request = Post.fetchRequest()
        if let searchText, !searchText.isEmpty {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchText)
        }
        do {
            if let context {
                posts = try context.fetch(request)
            } else {
                posts = try persistantContainer.viewContext.fetch(request)
            }
        } catch {
            print(error)
        }
    }
    
    func createPost(post: NewPost) {
        
        persistantContainer.performBackgroundTask { backContext in
            if self.findPosts(byAuthor: post.author, context: backContext) == nil {
                
                let newPosts = Post(context: backContext)
                newPosts.text = post.description
                newPosts.author = post.author
                newPosts.image = post.image
                newPosts.likes = "\(post.likes)"
                newPosts.views = "\(post.views)"
                
                do {
                    try backContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func deletePost(atIndexPath indexPath: IndexPath, completion: @escaping () -> Void) {
        // MARK:  Ошибка - "An NSManagedObjectContext cannot delete objects in other contexts.".
        // как удалить в бэке?
       /*
        persistantContainer.performBackgroundTask { backContext in
            self.loadPosts(context: backContext)
            backContext.delete(self.posts[indexPath.row])
            
            do {
               try backContext.save()
            } catch {
                print(error)
            }
            completion()
        }
        */
        
        loadPosts()
        persistantContainer.viewContext.delete(posts[indexPath.row])
        saveContext()
        completion()
    }
    
    private func findPosts(byAuthor author: String? = nil, context: NSManagedObjectContext) -> Post? {
        let fetchRequest = Post.fetchRequest()
        if let author {
            fetchRequest.predicate = NSPredicate(format: "author == %@", author)
        }
        return (try? context.fetch(fetchRequest))?.first
    }
}
