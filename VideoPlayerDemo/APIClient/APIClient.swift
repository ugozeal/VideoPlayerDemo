//
//  APIClient.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import Combine
import Foundation

struct ApiClient {
    static let shared = ApiClient()
    private init () {}
    
    static let apiKey = ""
    enum URLPath {
        static let apiBaseURL = "https://api.pexels.com/"
        
        case videos
        
        var urlPath: String {
            switch self {
            case .videos:
                return "videos/search"
            }
        }

    }
    /// Generic method to make requests
    /// - Parameters:
    ///   - urlPath: The Path to the resource in the back end
    ///   - method: Type of request to be made
    ///   - type: Generic type in consideration
    ///   - parameters: whatever information need to pass to the back End
    /// - Returns: Return type which is of type AnyPublisher
    private func makeRequest<T: Codable>(urlPath: URLPath, method: Method, type: T.Type, parameters: [String: Any]? = nil) -> AnyPublisher<T, Error> {
        let urlString = (URLPath.apiBaseURL + urlPath.urlPath).replacingOccurrences(of: " ", with: "%20")
        
        guard let url = urlString.asUrl else {
            fatalError("Fatal Error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(ApiClient.apiKey, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = method.rawValue
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .put, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//        jsonDecoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    fatalError("Service unavailable at the moment, please try again later")
                }
                return data
            }
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
    func findVideos(topic: Query)-> AnyPublisher<ResponseBody, Error> {
        let params = [
            "query": "\(topic)",
            "per_page": "10",
            "orientation": "portriat",
        ]
        
        return makeRequest(
            urlPath: .videos,
            method: .get,
            type: ResponseBody.self,
            parameters: params)
    }
}
