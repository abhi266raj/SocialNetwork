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
    @State private var isTapped = false
    @State private var selectedViewModel: PostViewModel?
    init() {
        viewModel.fetchData()
    }
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2)),
        GridItem(.fixed( UIScreen.main.bounds.width / 2))
       ]
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            }
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.postList, id: \.id) { postViewModel in
                        PostView(viewModel: postViewModel)
                            .frame( height: 300).clipped()
                            .onTapGesture {
                                isTapped = true
                                selectedViewModel = postViewModel
                            }
                    }
                    .sheet(item: $selectedViewModel, onDismiss: {
                        selectedViewModel = nil
                    }, content: { item in
                        let postId = String(item.id)
                        let vm = PostDetailViewModel(postId: postId)
                        PostDetailView(viewModel: vm)
                    })
                    
                    
                    
                }
                .padding()
            }
    }
}

#Preview {
    ContentView()
}

