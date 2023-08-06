//
//  FeedViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 05/08/23.
//

import Foundation
import Observation
import Model
import Service


@Observable class FeedListViewModel {
    
    public func fetchData() {
        let m = NetworkServiceImp()
        let request = JsonApiObject<FeedResponse>(requestBuilder: APIRequest.getFeed)
        Task {
            let response = try await m.fetchUsing(request)
            print (response)
        }
        
    }
}




@Observable class PostViewModel {
    private let post: Post

    init(post: Post) {
        self.post = post
    }

    var id: Int {
        return post.id
    }

    var videoURL: URL {
        return post.videoURL
    }

    var likes: Int {
        return post.likes
    }

    var thumbnailURL: URL {
        return post.thumbnailURL
    }

    var user: String {
        return post.user
    }

}

