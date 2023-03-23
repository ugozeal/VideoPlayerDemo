//
//  Model.swift
//  VideoPlayerDemo
//
//  Created by David Okonkwo on 23/03/2023.
//

import Foundation

enum Query: String, CaseIterable {
    case nature, animals, people, ocean, food
    var name: String {
        switch self {
        case .nature:
            return "nature"
        case .animals:
            return "animals"
        case .people:
            return "people"
        case .ocean:
            return "ocean"
        case .food:
            return "food"
        }
    }
}

struct ResponseBody: Codable {
    var page, perPage, totalResults: Int
    var url: String
    var videos: [Video]
}

struct Video: Identifiable, Codable {
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]
}

struct User: Identifiable, Codable {
    var id: Int
    var name: String
    var url: String
}

struct VideoFile: Identifiable, Codable {
    var id: Int
    var quality, fileType, link: String
}
