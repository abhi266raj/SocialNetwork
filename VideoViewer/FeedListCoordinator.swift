//
//  HomeCoordinator.swift
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

class FeedListCoordinator {
    @Bindable var viewModel: FeedListViewModel
    private let view: FeedView
    private var detailCoordinator:PostDetailCoordinator? = nil
    
    init() {
        let viewModel = FeedListViewModel()
        self.viewModel = viewModel
        self.view = FeedView(viewModel: viewModel)
    }
    
    func createView() -> some View {
        self.view.sheet(item: $viewModel.selectedPostViewModel) {
            [weak self] in
            self?.viewModel.selectedPostViewModel = nil
            self?.detailCoordinator = nil
        } content: { [weak self]  post in
            self?.getCoordinator(postId: post.id).createView()
        }
        
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





