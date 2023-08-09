//
//  ProfileDetailViewModel.swift
//  ViewModel
//
//  Created by Abhiraj on 06/08/23.
//

import Observation
import Model
import Service

@Observable public class ProfileDetailViewModel: ApiCallLodable {
    public var selectedViewModel: PostViewModel? = nil
    public var profile: UserProfileViewModel? = nil
    private let networkService: NetworkService
    private let userName: String
    public let firstApiViewModel: APIResultViewModel = APIResultViewModel()
    
    public init(userName: String, networkService: NetworkService) {
        self.userName = userName
        self.networkService = networkService
        firstApiViewModel.fetchData = { [weak self] in
            self?.fetchData()
        }
    }
    
    
    public func fetchData() {
        let request = JsonApiObject<ProfileDetailModel>(requestBuilder: APIRequest.getProfile(username: userName))
        Task {
            if let response = try? await firstApiViewModel.getResult(apiObject: request, networkService: networkService)  {
                self.profile = UserProfileViewModel(userProfile: response.data)
                for item in self.profile?.postList ?? [] {
                    item.onTap = { [weak self] item  in
                        self?.selectedViewModel = item
                    }
               }
            }
        }
        
    }
}


// ViewModel for UserProfile
public class UserProfileViewModel {
    public let id: String
    public let name: String
    public let userName: String
    public let email: String
    public let profilePic: String
    public var postList: [PostViewModel] = []
    

    init(userProfile: UserProfile) {
        id = userProfile.id
        name = userProfile.name
        userName = userProfile.userName
        email = userProfile.email
        profilePic = userProfile.profilePic
        postList = userProfile.posts.map { PostViewModel(post: $0)}
    }
}








