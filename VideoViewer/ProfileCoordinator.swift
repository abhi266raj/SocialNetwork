//
//  ProfileCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI

class ProfileCoordinator: Coordinator {
    @Bindable var viewModel: ProfileDetailViewModel
    private let view: UserProfileDetailView
    private var detailCoordinator:PostDetailCoordinator? = nil
    
    public init(_ userName: String) {
        let viewModel = ProfileDetailViewModel(userName: userName)
        self.viewModel = viewModel
        self.view = UserProfileDetailView(viewModel: viewModel)
    }
    
    func createView() -> AnyView {
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
        
        let coordinator  = PostDetailCoordinator(postId)
        detailCoordinator = coordinator
        return coordinator
    }
}


