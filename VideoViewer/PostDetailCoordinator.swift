//
//  PostDetailCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI

class PostDetailCoordinator: Coordinator {
    @Bindable var viewModel: PostDetailViewModel
    private let view: PostDetailView
    private var profileCoordinator:ProfileCoordinator? = nil
    
    init(_ postId: Int) {
        let post = String(postId)
        let viewModel = PostDetailViewModel(postId: post)
        self.viewModel = viewModel
        self.view = PostDetailView(viewModel: viewModel)
    }
    
    func createView() -> AnyView {
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
        
        let coordinator  = ProfileCoordinator(user)
        profileCoordinator = coordinator
        return coordinator
    }
}

