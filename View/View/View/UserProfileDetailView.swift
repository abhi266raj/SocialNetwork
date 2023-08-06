//
//  UserDetailView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import Foundation
import SwiftUI
import ViewModel
import AVFoundation


public struct UserProfileDetailView: View {
    var viewModel: ProfileDetailViewModel
    
    public init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
        viewModel.fetchData()
    }
    
    
    
    public var body: some View {
        if viewModel.profile == nil {
            ProgressView()
        } else {
            if let posts = viewModel.profile?.postList {
                PostListView(viewModelList: posts)
            }
        }
    }
}
