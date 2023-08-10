//
//  FeedView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel
import Service

public struct FeedView: View {
    public let viewModel:FeedListViewModel
    
    public init(viewModel: FeedListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        FirstApiView(viewModel: viewModel) {
            VStack {
                Text("Feed").font(.system(size: 30))
                PostListView(viewModelList: viewModel.postList).refreshable {
                    await viewModel.pullToRefresh()
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Themes.background)
    }
}

#Preview {
    {
        VStack {
            FeedView(viewModel: FeedListViewModel(networkService: MockNetworkService().feedAPI()))
        }
        
    }()
}
