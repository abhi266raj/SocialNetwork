//
//  PostDetailView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel
import AVKit

public struct PostDetailView: View {
    var viewModel: PostDetailViewModel
    
    public init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
    }
    
    
    
    public var body: some View {
        FirstApiView(viewModel: viewModel) {
                if let postViewModel = viewModel.post {
                    PostVideoView(viewModel: postViewModel) // Show PostView with postViewModel
                }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Themes.background)
    }
}

public struct PostVideoView: View {
    var viewModel: PostViewModel
    @State private var isVideoPlaying = false
    private var player: AVPlayer?
    
    public init(viewModel: PostViewModel) {
        self.viewModel = viewModel
        if let videoURL = URL(string: viewModel.videoURL) {
            player = AVPlayer(url: videoURL)
        }
    }
    
    public var body: some View {
        VStack(alignment: .center) {
            ZStack(alignment: .bottomTrailing) {
                if let imageUrl = URL(string: viewModel.thumbnailURL), let player = player {
                    VideoPlayerView(imageUrl: imageUrl, player: player)
                }
                LikeButtonView().frame(width: 50, height: 50).padding(20)
            }.padding()
            Group {
                ZStack {
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity )
                        .background(Themes.other)
                    VStack (alignment: .leading) {
                        Spacer()
                        HStack  () {
                            Spacer().frame(width: 10)
                            Image(systemName: "person.fill") // Replace this with an
                            Text(viewModel.user)
                            Spacer()
                        }
                        .frame(alignment: .center)
                        .padding([.top, .bottom], 4)
                        
                        HStack () {
                            Spacer().frame(width: 10)
                            Image(systemName: "heart.fill") // Replace this with an appropriate likes icon image
                            Text("\(viewModel.likes)")
                            Spacer()
                        }
                        .frame(alignment: .center)
                        .padding([.top, .bottom], 4)
                        Spacer()
                    }
                    
                }
            }
            .frame(maxWidth: .infinity,minHeight:50, maxHeight: 50, alignment: .bottom).onTapGesture {
                    viewModel.profileTapped()
                    player?.pause()
                }
        }
        
    }
    
}


private struct LikeButtonView: View {
    @State private var isLiked = false
    @State private var animate = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.isLiked.toggle()
                self.animate.toggle()
            }
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(isLiked ? .red : .gray)
                .scaleEffect(animate ? 1.05 : 1.0)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
