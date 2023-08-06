//
//  PostListView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel

public struct PostListView: View {
    let viewModelList: [PostViewModel]
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
                                postViewModel.postSelected()
                            }
                    }
                }
            }
    }
}




