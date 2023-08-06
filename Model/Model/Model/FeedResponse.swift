//
//  FeedModel.swift
//  Model
//
//  Created by Abhiraj on 05/08/23.
//

import Foundation


struct FeedResponse: Codable {
    let status: String
    let data: PostList
}

struct PostList: Codable {
    let count: Int
    let results: [Post]
}

struct Post: Codable {
    let id: Int
    let videoURL: URL
    let likes: Int
    let thumbnailURL: URL
    let user: String
}

