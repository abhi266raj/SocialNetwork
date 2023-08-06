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
    var viewModel = FeedListViewModel()
    init() {
        viewModel.fetchData()
    }
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2)),
        GridItem(.fixed( UIScreen.main.bounds.width / 2))
       ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.postList, id: \.id) { postViewModel in
                    PostView(viewModel: postViewModel)
                        .frame( height: 300).clipped()
                        .onTapGesture {
                            
                           print("Tapped")
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

