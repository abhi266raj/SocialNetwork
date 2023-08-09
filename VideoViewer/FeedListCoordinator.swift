//
//  HomeCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI

struct FeedContentFactory : AppContentFactory {
   
    typealias ViewModelElement = FeedListViewModel
    typealias ViewElement = FeedView
    
    var appDependecy: AppDependency
    
    func createViewModel() -> ViewModelElement {
        ViewModelElement(networkService: appDependecy.networkService)
    }
    
    func createView(from viewModel: ViewModelElement) -> ViewElement {
        ViewElement(viewModel: viewModel)
    }
    
}

class FeedListCoordinator: AppCoordinator<FeedContentFactory> {
  
    convenience init(appDependecy: AppDependency = DIConainer.shared) {
        let contentBuilder = ContentBuilder(appDependecy: appDependecy)
        self.init(contentBuilder: contentBuilder)
    }
    
    private var detailCoordinator:PostDetailCoordinator? = nil
        
    override func createView() -> AnyView {
        AnyView(self.view.sheet(item: $viewModel.selectedPostViewModel) {
            [weak self] in
            self?.viewModel.selectedPostViewModel = nil
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












