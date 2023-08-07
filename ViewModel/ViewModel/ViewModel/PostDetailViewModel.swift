//
//  PostViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 06/08/23.
//

import Observation
import Model
import Service

@Observable public class PostDetailViewModel: ApiCallLodable {
    public var post: PostViewModel? = nil
    public var selectedUser:Bool = false
    private let networkService: NetworkService
    private let postId: String
    public let firstApiViewModel: APIResultViewModel = APIResultViewModel()
    
    public init(postId: String, networkService: NetworkService = NetworkServiceImp()) {
        self.postId = postId
        self.networkService = networkService
        firstApiViewModel.fetchData = { [weak self] in
            self?.fetchData()
        }
    }
    
    public func fetchData() {
        let request = JsonApiObject<PostDetailModel>(requestBuilder: APIRequest.getPost(postID: postId))
        Task {
            if let response = try? await firstApiViewModel.getResult(apiObject: request, networkService: networkService)  {
                let viewModel = PostViewModel(post: response.data)
                viewModel.profileSelected = {[weak self] _ in
                    self?.selectedUser = true
                }
                self.post = viewModel
                
            }
        }
        
    }
}





