//
//  VideoView.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import AVKit
import SwiftUI

struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                if let link = video.videoFiles.first?.link {
                    player = AVPlayer(url: URL(string: link)!)
                    player.play()
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video: previewVideo)
    }
}
