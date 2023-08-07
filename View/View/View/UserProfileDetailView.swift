//
//  UserDetailView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel

public struct UserProfileDetailView: View {
    var viewModel: ProfileDetailViewModel
    
    public init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
        viewModel.fetchData()
    }
    
    public var body: some View {
        FirstApiView(viewModel: viewModel) {
            if let profile = viewModel.profile {
                VStack (alignment: .center) {
                    HStack (alignment: .center, spacing: 30) {
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
                    }.frame(maxWidth: .infinity,minHeight: 100, maxHeight: 100)
                        .background(Themes.darkBackground)
                    PostListView(viewModelList: profile.postList)
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Themes.background)
    }
}
