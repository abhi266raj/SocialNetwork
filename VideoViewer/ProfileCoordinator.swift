//
//  ProfileCoordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import ViewModel
import View
import SwiftUI
import Observation


struct ProfileContentFactory: AppContentFactory {
    typealias ViewModelElement = ProfileDetailViewModel
    typealias ViewElement = UserProfileDetailView
    
    var appDependecy: AppDependency
    var userName: String
    
    func createViewModel() -> ViewModelElement {
        ViewModelElement(userName: userName, networkService: appDependecy.networkService)
    }
    
    func createView(from viewModel: ViewModelElement) -> ViewElement {
        ViewElement(viewModel: viewModel)
    }
    
}

class ProfileCoordinator: AppCoordinator<ProfileContentFactory> {
   
    private var detailCoordinator:PostDetailCoordinator? = nil
    
    convenience init(_ userName: String, appDependecy: AppDependency) {
        let factory = ProfileContentFactory(appDependecy: appDependecy, userName: userName)
        self.init(contentBuilder: factory)
    }
    
    private var temp: Any?
    
    override func addObservation() {
        
        temp =  withObservationTracking {
            return self.viewModel.selectedViewModel
        } onChange: {
            DispatchQueue.main.async { [weak self] in
                self?.update()
                self?.addObservation()
            }
         }
    }
    
    func update() {
        if let model = self.viewModel.selectedViewModel {
            let c = PostDetailCoordinator(model.id, appDependecy: self.appDependecy)
            self.appDependecy.controller.push(c)
        }
    }
}


