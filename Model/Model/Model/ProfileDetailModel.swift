//
//  ProfileDetailModel.swift
//  Model
//
//  Created by Abhiraj on 06/08/23.
//

import Foundation


public struct ProfileDetailModel: Codable {
    public let status: String
    public let data: UserProfile
}

public struct UserProfile: Codable {
    public let id: String
    public let name: String
    public let userName: String
    public let email: String
    public let profilePic: String
    public let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case userName = "user_name"
        case profilePic = "profile_pic"
        case posts
    }
}
