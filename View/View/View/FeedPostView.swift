//
//  FeedPostView.swift
//  View
//
//  Created by Abhiraj on 05/08/23.
//


import SwiftUI
import ViewModel

public struct PostView: View {
    var viewModel: PostViewModel
    
    public init(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var isLoadingImage = true
    
    public var body: some View {
        VStack {
            ZStack {
               
                // Load thumbnail image from thumbnailURL
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: viewModel.thumbnailURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .onAppear {
                                    isLoadingImage = false
                                }
                            
                        case .failure(_):
                            Color.black.opacity(0.2)
                                .onAppear {
                                    isLoadingImage = false
                                }
                            
                        case .empty:
                            
                            Color.black.opacity(0.2)
                        @unknown default:
                            Color.gray.opacity(0.2)
                        }
                    }
                    VStack {
                        Spacer()
                        Group {
                            HStack {
                                HStack {
                                    Spacer().frame(width: 10)
                                    Image(systemName: "person.fill") // Replace this with an
                                    Text(viewModel.user)
                                    Spacer()
                                }
                                .frame(alignment: .center)
                                .padding([.top, .bottom], 4)
                                
                                HStack {
                                    Spacer()
                                    Image(systemName: "heart.fill") // Replace this with an appropriate likes icon image
                                    Text("\(viewModel.likes)")
                                    Spacer().frame(width: 10)
                                }
                                .frame(alignment: .center)
                                .padding([.top, .bottom], 4)
                            }
                        }.background(Color.gray)
                        .frame(height:30, alignment: .bottom)
                    }
                        
                        
                        
                    
                    
                }
            }
        }
    }
}


