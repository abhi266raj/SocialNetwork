//
//  PostDetailCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI

struct PostDetailContentFactory : AppContentFactory {
   
    typealias ViewModelElement = PostDetailViewModel
    typealias ViewElement = PostDetailView
    
    var appDependecy: AppDependency
    var postId: String
    
    func createViewModel() -> ViewModelElement {
        ViewModelElement(postId: postId, networkService: appDependecy.networkService)
    }
    
    func createView(from viewModel: ViewModelElement) -> ViewElement {
        ViewElement(viewModel: viewModel)
    }
}

class PostDetailCoordinator: AppCoordinator<PostDetailContentFactory> {
    
    private var profileCoordinator:ProfileCoordinator? = nil
        
    convenience init(_ postId: Int, appDependecy: AppDependency) {
        let factory = PostDetailContentFactory(appDependecy: appDependecy, postId: String(postId))
        self.init(contentBuilder: factory)
    }
    
    override func createView() -> AnyView {
        AnyView(self.view.sheet(isPresented: $viewModel.selectedUser) {
            self.viewModel.selectedUser  = false
        } content: { [weak self] in
            self?.getCoordinator(user: self?.viewModel.post?.user ?? "").createView()
        })
    }
    
    func getCoordinator(user: String) -> ProfileCoordinator {
        if let coordinator =  profileCoordinator {
            return coordinator
        }
        
        let coordinator  = ProfileCoordinator(user, appDependecy: appDependecy)
        profileCoordinator = coordinator
        return coordinator
    }
}



