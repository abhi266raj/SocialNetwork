//
//  FeedViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 05/08/23.
//

import Observation
import Model
import Service

@Observable public class FeedListViewModel: ApiCallLodable {
    let networkService: NetworkService
    public var isLoading = false
    public var selectedPostViewModel: PostViewModel? = nil
    public let firstApiViewModel: APIResultViewModel = APIResultViewModel()
    
    public var postList:[PostViewModel] = []
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
        firstApiViewModel.fetchData = { [weak self] in
            self?.fetchData()
        }
    }
    
    public func fetchData() {
        let request = JsonApiObject<FeedResponse>(requestBuilder: APIRequest.getFeed)
        Task {
            if let response = try? await firstApiViewModel.getResult(apiObject: request, networkService: networkService) {
                let postViewModelList = response.data.results.map { post in
                    PostViewModel(post: post) { [weak self] item  in
                        self?.selectedPostViewModel = item
                    }
                }
                postList = postViewModelList
                
            }
        }
    }
    
    public func pullToRefresh() async {
        let request = JsonApiObject<FeedResponse>(requestBuilder: APIRequest.getFeed)
        do  {
            let response = try await networkService.fetchUsing(request)
            let postViewModelList = response.data.results.map { post in
                PostViewModel(post: post) { [weak self] item  in
                    self?.selectedPostViewModel = item
                }

            }
            postList = postViewModelList
        } catch let (error) {
            print(error)
        }
        
    }
}


@Observable public class PostViewModel {
    private let post: Post
    
    var onTap: ((PostViewModel) -> Void)? = nil
    
    var profileSelected: ((String) -> Void)? = nil
    
    init(post: Post, onTap:((PostViewModel) -> Void)? = nil ) {
        self.post = post
        self.onTap = onTap
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
    
    public func postSelected() {
        onTap?(self)
    }
    
    public func profileTapped() {
        profileSelected?(user)
    }
    
}

extension PostViewModel : Identifiable {
    
}

