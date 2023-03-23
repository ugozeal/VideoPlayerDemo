//
//  ContentView.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var videoManager = VideoManager()
    @StateObject var videoPlayerViewModel = VideoPlayerViewModel()
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(Query.allCases, id: \.self) { query in
                        QueryTag(query: query, isSelected: videoPlayerViewModel.selectedQuery == query)
                            .onTapGesture {
                                videoPlayerViewModel.selectedQuery = query
                            }
                    }
                }
                
                ScrollView {
                    if videoPlayerViewModel.isLoading {
                        ProgressView()
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(videoPlayerViewModel.videos, id: \.id) { video in
                                NavigationLink {
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                }
                                
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.accentColor)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
