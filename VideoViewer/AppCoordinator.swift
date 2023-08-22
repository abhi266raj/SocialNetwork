//
//  AppCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 09/08/23.
//

import ViewModel
import View
import SwiftUI

class AppCoordinator<T: AppContentFactory>: Coordinator {
    
    static func == (lhs: AppCoordinator<T>, rhs: AppCoordinator<T>) -> Bool {
        return false
    }
    
    
    typealias ContentBuilder = T
   
    var viewModel: ContentBuilder.ViewModelElement
    var contentBuilder: ContentBuilder
    var appDependecy: AppDependency {
        contentBuilder.appDependecy
    }
    private var detailCoordinator:PostDetailCoordinator? = nil
  
    required init(contentBuilder: ContentBuilder) {
        let viewModel = contentBuilder.createViewModel()
        self.viewModel = viewModel
        self.contentBuilder = contentBuilder
        self.addObservation()
    }
    
    lazy var view: ContentBuilder.ViewElement = {
        contentBuilder.createView(from: viewModel)
    }()
        
    func addObservation() {
        
    }
}










