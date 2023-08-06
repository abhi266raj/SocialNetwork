//
//  ProfileCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import Foundation
import Service
import ViewModel
import Model
import View
import SwiftUI
import Observation


class ProfileCoordinator {
    @Bindable var viewModel: ProfileDetailViewModel
    private let view: UserProfileDetailView
    private var detailCoordinator:PostDetailCoordinator? = nil
    
    public init(_ userName: String) {
        let viewModel = ProfileDetailViewModel(userName: userName)
        self.viewModel = viewModel
        self.view = UserProfileDetailView(viewModel: viewModel)
    }
    
    func createView() -> some View {
        return self.view
//        self.view.sheet(item: $viewModel.selectedPostViewModel) {
//            [weak self] in
//            self?.viewModel.selectedPostViewModel = nil
//            self?.detailCoordinator = nil
//        } content: { [weak self]  post in
//            self?.getCoordinator(postId: post.id).createView()
//        }
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
