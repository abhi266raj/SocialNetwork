//
//  Coordinator.swift
//  VideoViewer
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import Service
import Observation
import ViewModel


protocol AppDependency {
    var networkService: NetworkService {get}
}


struct DIConainer {
    static let shared:AppDependency = AppDependecyImp()
    
    final private class AppDependecyImp: AppDependency {
        var networkService: NetworkService = NetworkServiceImp()
    }

}

protocol AppContentFactory {
    associatedtype ViewModelElement: Observable & AnyObject
    associatedtype ViewElement: View
    
    var appDependecy: AppDependency {get}
    func createViewModel() -> ViewModelElement
    func createView(from: ViewModelElement) -> ViewElement
}

protocol Coordinator {
    associatedtype ContentBuilder: AppContentFactory
    var viewModel: ContentBuilder.ViewModelElement {get}
    var view: ContentBuilder.ViewElement {get}
    func createView() -> AnyView
}







