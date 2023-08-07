//
//  VideoViewerApp.swift
//  VideoViewer
//
//  Created by Abhiraj on 05/08/23.
//

import SwiftUI

@main

private struct VideoViewerApp: App {
    var coordinator: Coordinator = FeedListCoordinator()
    var body: some Scene {
        WindowGroup {
            coordinator.createView()
        }
    }
}


