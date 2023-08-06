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


@Observable public class FeedListViewModel {
    let networkService = NetworkServiceImp()
    
    public var postList:[PostViewModel] = []
    
    public init() {
        
    }
    
    public func fetchData() {
        let request = JsonApiObject<FeedResponse>(requestBuilder: APIRequest.getFeed)
        Task {
            do  {
                let response = try await networkService.fetchUsing(request)
                let postViewModelList = response.data.results.map { post in
                    PostViewModel(post: post)
                }
                postList = postViewModelList
                
            } catch let (error) {
                print(error)
            }
        }
        
    }
}




@Observable public class PostViewModel {
    private let post: Post

    init(post: Post) {
        self.post = post
    }

    public var id: Int {
        return post.id
    }

    public var videoURL: String {
        return post.videoURL
    }

    public var likes: Int {
        return post.likes
    }

    public var thumbnailURL: String {
        return post.thumbnailURL
    }

    public var user: String {
        return post.user
    }

}

