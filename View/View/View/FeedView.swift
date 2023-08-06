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
            if viewModel.isLoading {
                ProgressView()
            }
            PostListView(viewModelList: viewModel.postList).refreshable {
                await viewModel.pullToRefresh()
            }
    }
}
