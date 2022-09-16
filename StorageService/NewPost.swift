//
//  Post.swift
//  StorageService
//
//  Created by Dima Shikhalev on 14.09.2022.
//

import Foundation

public struct NewPost {
    
    public let author: String
    public  let description: String
    public let image: String
    public let likes: Int
    public let views: Int
}


private let post1 = NewPost(author: "Apple", description: "an information technology conference held annually by Apple Inc. The conference is usually held at Apple Park in California.", image: "wwdc", likes: 11786, views: 1232515)

private let post2 = NewPost(author: "michaeljordan", description: "Ready to fight", image: "jordan", likes: 124642, views: 12456324)

private let post3 = NewPost(author: "bmwRussia", description: "Freude am Fahren («С удовольствием за рулем»)", image: "bmw", likes: 53134, views: 914512)

private let post4 = NewPost(author: "Harvard_Business_Review", description: "New magazine", image: "harward", likes: 5214, views: 91241)


public var postArray: [NewPost] = [post1, post2, post3, post4]
