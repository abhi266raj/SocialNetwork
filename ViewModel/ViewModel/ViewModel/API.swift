//
//  API.swift
//  ViewModel
//
//  Created by Abhiraj on 05/08/23.
//

import Foundation
import Service

public enum APIRequest {
    case getFeed
    case getPost(postID: String)
    case getProfile(username: String)
}

extension APIRequest: RequestBuilder {
    public func createRequest() -> URLRequest {
        var url: URL
        switch self {
        case .getFeed:
            url = URL(string: "http://interview.talkshopclub.com:3010/api/feed")!
        case .getPost(let postID):
            url = URL(string: "http://interview.talkshopclub.com:3010/api/posts/\(postID)")!
        case .getProfile(let username):
            url = URL(string: "http://interview.talkshopclub.com:3010/api/profile/\(username)")!
        }

        // Assuming these APIs use GET method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

public struct JsonApiObject<T:Decodable>: NetworkObject {
    public var requestBuilder: APIRequest
    public let responseBuilder = ModelResponseBuilder<T>()
    public init(requestBuilder: APIRequest) {
        self.requestBuilder = requestBuilder
    }
}







