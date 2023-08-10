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
        GridItem(.fixed(UIScreen.main.bounds.width / 2 - 30), spacing: 20),
        GridItem(.fixed( UIScreen.main.bounds.width / 2 - 30), spacing: 20)
       ]
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(Array(viewModelList.enumerated()), id: \.element.id) { index, postViewModel in
                        PostView(viewModel: postViewModel)
                            .frame( height: 300).clipped()
                            .cornerRadius(5)
                            .onTapGesture {
                                postViewModel.postSelected()
                            }.accessibilityIdentifier("item\(index)")
                    }
                }
        }
    }
}




