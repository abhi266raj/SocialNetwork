//
//  InitialApiView.swift
//  View
//
//  Created by Abhiraj on 07/08/23.
//

import SwiftUI
import ViewModel

public struct FirstApiView <Content>: View where Content: View {
    
    
    var successView: Content
    var viewModel: APIResultViewModel
    
    init(viewModel: ApiCallLodable, @ViewBuilder successView: () -> Content ) {
        self.viewModel = viewModel.firstApiViewModel
        self.successView = successView()
    }
    
    public var body: some View {
        Group {
            switch viewModel.state  {
            case .initial:
                ProgressView().onAppear {
                    viewModel.fetchDataIfNeeded()
                }
            case .loading:
                ProgressView()
            case .success:
                VStack {
                    successView
                }
            case .error(let value):
                ZStack {
                    Color.red.opacity(0.4)
                    
                    Button(action: {
                        viewModel.fetchDataIfNeeded()
                    }) {
                        VStack {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                            
                            Text("Retry")
                                .font(.headline)
                            
                            Text("Error: \(value)")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20) // Add horizontal padding for better spacing
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }

            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}




