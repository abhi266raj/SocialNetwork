//
//  FeedView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel

public struct FeedView: View {
    public let viewModel:FeedListViewModel
    
    public init(viewModel: FeedListViewModel) {
        self.viewModel = viewModel
         viewModel.fetchData()
    }
    
    public var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text("Feed").font(.system(size: 30)) 
                PostListView(viewModelList: viewModel.postList).refreshable {
                    await viewModel.pullToRefresh()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Themes.background)
    }
}
