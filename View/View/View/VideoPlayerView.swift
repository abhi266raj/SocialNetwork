import SwiftUI
import AVKit

fileprivate extension View {
    func hide(_ status : Bool) -> AnyView {
        if status == true {
            return AnyView(self)
        }
        return AnyView(self.hidden())
    }
}

struct VideoPlayerView: View {
    @ObservedObject private var player: PlayerViewModel = PlayerViewModel()
    
    private var imageUrl: URL
    
    init(imageUrl: URL, videoUrl: URL) {
        self.imageUrl = imageUrl
        let player = AVPlayer(url: videoUrl)
        self.player.update(avplayer: player)
    }
    
    init(imageUrl: URL, player: AVPlayer) {
        self.imageUrl = imageUrl
        self.player.update(avplayer: player)
    }
    
    var body: some View {
        ZStack {
                CachedAsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .empty:
                        ProgressView()
                    case .failure:
                        Color.red
                    @unknown default:
                        ProgressView()
                            .scaleEffect(1.5)
                    }
                }.onTapGesture {
                    player.player?.play()
                }
                        
            if let avplayer = player.player {
                VideoPlayer(player: avplayer).hide(player.hasPlayedOnce)
            }
            
        }.background(.black)
        
        .onAppear() {
            player.player?.play()
        }.onDisappear() {
            player.player?.pause()
        }
    }
    
}

class PlayerViewModel:ObservableObject {
    
    var player:AVPlayer?
    @Published var isPlaying: Bool = false
    @Published var hasPlayedOnce: Bool = false
    private var cancelBag:Any?
    
    func update(avplayer: AVPlayer) {
        print ("Updated called")
        self.player?.pause()
        isPlaying = false
        hasPlayedOnce = false
        player = avplayer
        let publisher = avplayer.publisher(for: \.timeControlStatus).map({ [weak self] value in
            if value != .playing {
                return false
            } else {
                self?.hasPlayedOnce = true
            }
            return true
        }).receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        cancelBag = publisher.assign(to: \.isPlaying, on: self)
        
    }
}









public struct ContentView: View {
    public var body: some View {
        VideoPlayerView(imageUrl: URL(string: "https://image.mux.com/2KmAsqY8vytXU1DxKr52OhbyHtKG3hG022dvlRez6kj00/thumbnail.png")!,
                        videoUrl: URL(string: "https://stream.mux.com/Nfg00Va6dpv01jn7EqYZW63ss7JbWhHxPaYPXLHZMOG98.m3u8")!)
    }
    public init(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
