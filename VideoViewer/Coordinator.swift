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
    var controller: Controller {get}
}



struct DIConainer {
    static let shared: AppDependency = AppDependecyImp()
    
    @Observable
    final class AppDependecyImp: NSObject, AppDependency {
        var networkService: NetworkService = NetworkLoggingProxy(NetworkServiceImp())
        var controller =  Controller()
    }
}

protocol AppContentFactory {
    associatedtype ViewModelElement: Observable & AnyObject
    associatedtype ViewElement: View
    
    var appDependecy: AppDependency {get}
    func createViewModel() -> ViewModelElement
    func createView(from: ViewModelElement) -> ViewElement
}

protocol Coordinator: Hashable  & AnyObject {
    associatedtype ContentBuilder: AppContentFactory
    var viewModel: ContentBuilder.ViewModelElement {get}
    var view: ContentBuilder.ViewElement {get}
}

extension Coordinator  {
    static func == (lhs: Self, rhs: Self) -> Bool {
        // Implement equality based on viewModel and view
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}






