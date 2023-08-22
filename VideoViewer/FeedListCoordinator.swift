//
//  HomeCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI
import Observation

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
    
    private var temp: Any?
    
    override func addObservation() {
       temp =  withObservationTracking {
           return self.viewModel.selectedPostViewModel
       } onChange: { [self] in
           DispatchQueue.main.async { [weak self] in
               self?.update()
               self?.addObservation()
           }
        }
    }
    
    func update() {
        if let model = self.viewModel.selectedPostViewModel {
            let c = PostDetailCoordinator(model.id, appDependecy: self.appDependecy)
            //self.appDependecy.controller.navigationPath.append(c)
            self.appDependecy.controller.presentedCoordinator = c
        }
        
    }
    
}












