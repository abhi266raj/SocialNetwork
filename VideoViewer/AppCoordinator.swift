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
    
    typealias ContentBuilder = T
   
    @Bindable var viewModel: ContentBuilder.ViewModelElement
    let view: ContentBuilder.ViewElement
    var appDependecy: AppDependency
    private var detailCoordinator:PostDetailCoordinator? = nil
  
    required init(contentBuilder: ContentBuilder) {
        let viewModel = contentBuilder.createViewModel()
        let view = contentBuilder.createView(from: viewModel)
        self.viewModel = viewModel
        self.view = view
        self.appDependecy = contentBuilder.appDependecy
    }
    
    func createView() -> AnyView {
        AnyView(self.view)
    }
}










