//
//  PostListView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel

public struct PostListView: View {
    
    private struct Constants {
        static let hspacing:CGFloat = 15
        static let width:CGFloat =  {
            UIScreen.main.bounds.width / 2 - (3 * Self.hspacing)/2
        }()
        
        static let vspacing:CGFloat = 20
        
        static let height:CGFloat = {
            Self.width * 2
        }()
    }
    
    let viewModelList: [PostViewModel]
    public init(viewModelList: [PostViewModel]) {
        self.viewModelList = viewModelList
    }
    let columns: [GridItem] = [
        GridItem(.fixed(Self.Constants.width), spacing: Self.Constants.hspacing),
        GridItem(.fixed( Self.Constants.width), spacing: Self.Constants.hspacing)
       ]
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: Self.Constants.vspacing) {
                ForEach(Array(viewModelList.enumerated()), id: \.element.id) { index, postViewModel in
                        PostView(viewModel: postViewModel)
                        .frame( height: Self.Constants.height).clipped()
                        .border(.gray.opacity(0.5), width: 2)
                        .cornerRadius(5)
                            .onTapGesture {
                                postViewModel.postSelected()
                            }.accessibilityIdentifier("item\(index)")
                    }
                }
        }
    }
}




