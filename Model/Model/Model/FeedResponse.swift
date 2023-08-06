//
//  FeedModel.swift
//  Model
//
//  Created by Abhiraj on 05/08/23.
//

import Foundation


public struct FeedResponse: Codable {
    public let status: String
    public let data: PostList
}

public struct PostList: Codable {
    public let count: Int
    public let results: [Post]
}

public struct Post: Codable {
    public let id: Int
    public let videoURL: String
    public let likes: Int
    public let thumbnailURL: String
    public let user: String
    
    private enum CodingKeys: String, CodingKey {
            case id
            case videoURL = "video_url"
            case likes
            case thumbnailURL = "thumbnail_url"
            case user
        }
}

