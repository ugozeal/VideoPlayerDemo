//
//  VideoPlayerViewModel.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import Combine
import Foundation

final class VideoPlayerViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var isLoading = false
    @Published private(set) var videos: [Video] = []
    @Published var selectedQuery: Query = Query.nature {
        didSet {
            fetchVideos(topic: selectedQuery)
        }
    }
    
    init() {
        fetchVideos(topic: selectedQuery)
    }
    
    func fetchVideos(topic: Query) {
        isLoading = true
        cancellable = ApiClient.shared.findVideos(topic: topic)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished video")
                case .failure(let error):
                    print("Error is \(error.localizedDescription)")
                }
                self.isLoading = false
            }, receiveValue: { response in
                self.videos.removeAll()
                self.videos = response.videos
            })
    }
}
