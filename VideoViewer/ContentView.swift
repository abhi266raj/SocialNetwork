//
//  ContentView.swift
//  VideoViewer
//
//  Created by Abhiraj on 05/08/23.
//

import SwiftUI
import Service
import ViewModel
import Model
import View

struct ContentView: View {
    let item = FeedListCoordinator()
    
    var body: some View {
         item.createView()
    }
}

#Preview {
    ContentView()
}

