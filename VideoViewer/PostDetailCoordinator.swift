//
//  PostDetailCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI
import Observation

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
   
    convenience init(_ postId: Int, appDependecy: AppDependency) {
        let factory = PostDetailContentFactory(appDependecy: appDependecy, postId: String(postId))
        self.init(contentBuilder: factory)
    }
        
    private var temp: Any?
    
    override func addObservation() {
        
        temp =  withObservationTracking {
            return self.viewModel.selectedUser
        } onChange: { [self] in
            // guard let self else {return}
            DispatchQueue.main.async {
                self.update()
                self.addObservation()
            }
         }
    }
    
    func update() {
        if self.viewModel.selectedUser,
        let user = self.viewModel.post?.user {
            let c = ProfileCoordinator(user, appDependecy: self.appDependecy)
            self.appDependecy.controller.push(c)
        }
    }
    
    
}



