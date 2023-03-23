//
//  VideoCard.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import SwiftUI

struct VideoCard: View {
    var video: Video
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: video.image)) { image in
                ZStack {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 250)
                        .cornerRadius(30)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(50)
                }
            } placeholder: {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(width: 160, height: 250)
                .background(.gray.opacity(0.3))
                .cornerRadius(30)
            }
            
            VStack(alignment: .leading) {
                Text("\(video.duration) sec")
                
                Text("By \(video.user.name)")
                    .multilineTextAlignment(.leading)
            }
            .font(.caption)
            .bold()
            .foregroundColor(.white)
            .shadow(radius: 20)
            .padding()
        }
    }
}

struct VideoCard_Previews: PreviewProvider {
    static var previews: some View {
        VideoCard(video: previewVideo)
    }
}
