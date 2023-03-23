//
//  VideoManager.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import UIKit

/// This file was not used since we decided to use a ViewModel
final class VideoManager: ObservableObject {
    @Published private(set) var videos: [Video] = []
    @Published var isLoading = false
    @Published var selectedQuery: Query = Query.nature {
        didSet {
            Task.init {
                await findVideos(topic: selectedQuery)
            }
        }
    }
    
    init() {
        Task.init {
            await findVideos(topic: selectedQuery)
        }
    }
    
    func findVideos(topic: Query) async {
        isLoading = true
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientation=portriat") else {
                fatalError("Missing URL")
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("0ki2W3Hj5ouLQy79dZ2XUXldTdiyyYiZZEhW1rsURhkB1Cz2uVJFt63w", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data")
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(ResponseBody.self, from: data)
            DispatchQueue.main.async {
                self.videos = []
                self.videos = decodedData.videos
                self.isLoading = false
            }
        } catch {
            self.isLoading = false
            print("Error fetching data from Pexels: \(error)")
        }
    }
}
