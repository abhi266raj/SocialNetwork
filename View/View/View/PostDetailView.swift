//
//  PostDetailView.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI
import ViewModel
import _AVKit_SwiftUI

public struct PostDetailView: View {
    var viewModel: PostDetailViewModel
    
    public init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        viewModel.fetchData()
    }
    
    
    
    public var body: some View {
        if viewModel.post == nil {
            ProgressView() // Show the loader when postViewModel is nil
        } else {
            if let postViewModel = viewModel.post {
                PostVideoView(viewModel: postViewModel) // Show PostView with postViewModel
            }
        }
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
        VStack {
            Group {
                if let player {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.play()
                            isVideoPlaying = true
                        }
                        .onDisappear {
                            player.pause()
                            isVideoPlaying = false
                        }
                } else {
                    Color.red.opacity(0.2)
                }
            }.padding()
            Spacer().frame(height:20)
            Group {
                VStack {
                    Spacer()
                    HStack {
                        Spacer().frame(width: 10)
                        Image(systemName: "person.fill") // Replace this with an
                        Text(viewModel.user)
                        Spacer()
                    }
                    .frame(alignment: .center)
                    .padding([.top, .bottom], 4)
                    
                    HStack {
                        Spacer().frame(width: 10)
                        Image(systemName: "heart.fill") // Replace this with an appropriate likes icon image
                        Text("\(viewModel.likes)")
                        Spacer()
                    }
                    .frame(alignment: .center)
                    .padding([.top, .bottom], 4)
                    Spacer()
                }
            }.background(Color.gray)
                .frame(height:50, alignment: .bottom).onTapGesture {
                    viewModel.profileTapped()
                    player?.pause()
                }
        }
    }
    
}





