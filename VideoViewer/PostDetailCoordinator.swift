//
//  PostDetailCoordinator.swift
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

class PostDetailCoordinator {
    @Bindable var viewModel: PostDetailViewModel
    private let view: PostDetailView
    
    init(_ postId: Int) {
        let post = String(postId)
        let viewModel = PostDetailViewModel(postId: post)
        self.viewModel = viewModel
        self.view = PostDetailView(viewModel: viewModel)
    }
    
    func createView() -> some View {
        self.view.sheet(isPresented: $viewModel.selectedUser) {
            self.viewModel.selectedUser  = false
        } content: {
            ProfileCoordinator(self.viewModel.post?.user ?? "").createView()
        }
    }
}

