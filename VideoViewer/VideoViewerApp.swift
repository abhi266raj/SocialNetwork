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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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
                
            }.onOpenURL(perform: { url in
                controller.deepLinkUrl = url
            })
        }
    }
}

@Observable
class Controller {
    var navigationPath = NavigationPath()
    @ObservationIgnored
    var deepLinkUrl: URL? = nil {
        didSet {
            handleDeepLink()
        }
    }
    
    func handleDeepLink() {
        defer {
            if deepLinkUrl != nil {
                deepLinkUrl = nil
            }
        }
        if let deepLinkUrl = deepLinkUrl {
            let pathComponent = deepLinkUrl.pathComponents
            if pathComponent.count <= 1 {
                goToHome()
                return
            }
            
            switch pathComponent[1] {
            case "feed":
                goToHome()
            case "profile":
                if pathComponent.count > 2 {
                    let profile = pathComponent[2]
                    let coordinator = ProfileCoordinator(profile, appDependecy: DIConainer.shared)
                    push(coordinator)
                }else {
                    goToHome()
                }
            case "post":
                if pathComponent.count > 2, let postId = Int(pathComponent[2]) {
                    let coordinator = PostDetailCoordinator(postId, appDependecy: DIConainer.shared)
                    push(coordinator)
                }else {
                    goToHome()
                }
            
            default:
                goToHome()
            }
            
            
            
            
        
        }
        
    }
    
    func goToHome() {
        self.isPresented = false
        self.navigationPath.removeLast(navigationPath.count)
        
    }
    
    
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


class AppDelegate: NSObject, UIApplicationDelegate {
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if CommandLine.arguments.contains("-openURL") {
            if let urlIndex = CommandLine.arguments.firstIndex(of: "-openURL"), urlIndex + 1 < CommandLine.arguments.count {
                let urlString = CommandLine.arguments[urlIndex + 1]
                if let url = URL(string: urlString) {
                    DIConainer.shared.controller.deepLinkUrl = url
                    
                    // Handle the URL opening here
                    // You can navigate to a specific screen, update state, etc.
                }
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        DIConainer.shared.controller.deepLinkUrl = url
        return true
        
    }
    
    
}





