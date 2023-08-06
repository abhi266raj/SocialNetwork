//
//  PostViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 06/08/23.
//

import Foundation
import Observation
import Model
import Service


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


@Observable public class PostDetailViewModel {
    public var post: PostViewModel? = nil
    private let networkService = NetworkServiceImp()
    private let postId: String
    
    public init(postId: String) {
        self.postId = postId
    }
    
    
    
    public func fetchData() {
        let request = JsonApiObject<PostDetailModel>(requestBuilder: APIRequest.getPost(postID: postId))
        Task {
            do  {
                let response = try await networkService.fetchUsing(request)
                let viewModel = PostViewModel(post: response.data)
                self.post = viewModel
            } catch let (error) {
                print(error)
            }
        }
        
    }
}





