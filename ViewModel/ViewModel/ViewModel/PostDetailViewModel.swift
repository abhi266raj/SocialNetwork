//
//  PostViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 06/08/23.
//

import Observation
import Model
import Service

@Observable public class PostDetailViewModel {
    public var post: PostViewModel? = nil
    public var selectedUser:Bool = false
    private let networkService: NetworkService
    private let postId: String
    
    public init(postId: String, networkService: NetworkService = NetworkServiceImp()) {
        self.postId = postId
        self.networkService = networkService
    }
    
    
    
    public func fetchData() {
        let request = JsonApiObject<PostDetailModel>(requestBuilder: APIRequest.getPost(postID: postId))
        Task {
            do  {
                let response = try await networkService.fetchUsing(request)
                let viewModel = PostViewModel(post: response.data)
                viewModel.profileSelected = {[weak self] _ in
                        self?.selectedUser = true
                }
                self.post = viewModel
            } catch let (error) {
                print(error)
            }
        }
        
    }
}





