//
//  ProfileCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI



struct ProfileContentFactory: AppContentFactory {
    typealias ViewModelElement = ProfileDetailViewModel
    typealias ViewElement = UserProfileDetailView
    
    var appDependecy: AppDependency
    var userName: String
    
    func createViewModel() -> ViewModelElement {
        ViewModelElement(userName: userName, networkService: appDependecy.networkService)
    }
    
    func createView(from viewModel: ViewModelElement) -> ViewElement {
        ViewElement(viewModel: viewModel)
    }
    
}

class ProfileCoordinator: AppCoordinator<ProfileContentFactory> {
   
    private var detailCoordinator:PostDetailCoordinator? = nil
    
    convenience init(_ userName: String, appDependecy: AppDependency) {
        let viewModel = ProfileDetailViewModel(userName: userName)
        let factory = ProfileContentFactory(appDependecy: appDependecy, userName: userName)
        self.init(contentBuilder: factory)
    }
    
    override func createView() -> AnyView {
        AnyView(self.view.sheet(item: $viewModel.selectedViewModel) {
            [weak self] in
            self?.viewModel.selectedViewModel = nil
            self?.detailCoordinator = nil
        } content: { [weak self]  post in
            self?.getCoordinator(postId: post.id).createView()
        })
    }
    
    func getCoordinator(postId: Int) -> PostDetailCoordinator {
        if let coordinator =  detailCoordinator {
            return coordinator
        }
        
        let coordinator  = PostDetailCoordinator(postId, appDependecy: appDependecy)
        detailCoordinator = coordinator
        return coordinator
    }
}


