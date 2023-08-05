//
//  ContentView.swift
//  VideoViewer
//
//  Created by Abhiraj on 05/08/23.
//

import SwiftUI
import Service
import ViewModel

struct ContentView: View {
    
    init() {
        let m = NetworkServiceImp()
        let request = JsonApiObject<FeedResponse>(requestBuilder: APIRequest.getFeed)
        Task {
            let k = try await m.fetchUsing(request)
            print(k)
        }
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

