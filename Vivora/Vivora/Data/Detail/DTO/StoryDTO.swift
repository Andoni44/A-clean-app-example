//
//  StoryDTO.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// MARK: - StoryDTO

struct StoryDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: StoryDataClass
}

// MARK: - StoryDataClass

struct StoryDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [StoryResult]
}

// MARK: - Result

struct StoryResult: Codable {
    let id: Int
    let title: String
    let resourceURI: String
    let type: String
    let thumbnail: Thumbnail?
    let creators, characters, series, comics: Characters
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id, title
        case resourceURI, type, thumbnail, creators, characters, series, comics, events
    }
}
