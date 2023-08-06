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
            if let profile = viewModel.profile {
                HStack (alignment: .center) {
                        AsyncImage(url: URL(string: profile.profilePic)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100)
                        
                    VStack(alignment: .leading) {
                            Text("\(profile.name)")
                            Text("\(profile.userName)")
                            Text("\(profile.email)")
                        }
                        
                    //}
                }.frame(height: 100)
                
                PostListView(viewModelList: profile.postList)
            }
        }
    }
}
