//
//  VideoViewerApp.swift
//  VideoViewer
//
//  Created by Abhiraj on 05/08/23.
//

import ViewModel
import View
import SwiftUI
import Observation


@main

private struct VideoViewerApp: App {
    @Bindable var controller = DIConainer.shared.controller
    var rootCoordinator = FeedListCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $controller.navigationPath) {
                VStack {
                    AppLaunchView(item: AnyView(rootCoordinator.view))
                }
            }.sheet( isPresented: $controller.isPresented) {
                controller.presentedCoordinator = nil
            } content: {
                    controller.presentedCoordinator?.anyView
                
            }
        }
    }
}

@Observable
class Controller {
    var navigationPath = NavigationPath()
    
    func push<T:Coordinator>(_ item:T) {
        if (self.presentedCoordinator != nil) {
            self.isPresented = false
            DispatchQueue.main.async {
                self.push(item)
            }
            return
        }
        navigationPath.append(item)
    }
    
    @ObservationIgnored
    var presentedCoordinator: (any Coordinator)? = nil {
        didSet {
            if presentedCoordinator == nil {
                isPresented = false
            }else {
                isPresented = true
            }
        }
    }
    var isPresented = false
    
}

extension Coordinator {
    var anyView:AnyView {
        AnyView(view)
    }
}


struct AppLaunchView: View {
    
    
    @State var item: AnyView
    var body: some View {
        item.addNavigation(type: PostDetailCoordinator.self)
            .addNavigation(type: ProfileCoordinator.self)
            .addNavigation(type: FeedListCoordinator.self)
    }
}

extension View {
    
    func addNavigation<T: Coordinator>(type: T.Type) -> some View {
        self.navigationDestination(for: type.self) {$0.view}
    }
}





