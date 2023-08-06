//
//  PostListView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import Foundation
import SwiftUI
import ViewModel
import AVFoundation


public struct PostListView: View {
    let viewModelList: [PostViewModel]
    @State private var isTapped = false
    @State private var selectedViewModel: PostViewModel?
    public init(viewModelList: [PostViewModel]) {
        self.viewModelList = viewModelList
    }
    
    let columns: [GridItem] = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2)),
        GridItem(.fixed( UIScreen.main.bounds.width / 2))
       ]
    
    public var body: some View {
        ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModelList, id: \.id) { postViewModel in
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
            }
    }
}




