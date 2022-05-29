//
//  EventDTO.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// MARK: - EventDTO

struct EventDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: EventDataClass
}

// MARK: - EventDataClass

struct EventDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [EventResult]
}

// MARK: - EventResult

struct EventResult: Codable {
    let id: Int
    let title: String
    let resourceURI: String
    let urls: [URLElement]
    let start, end: String
    let thumbnail: Thumbnail
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let comics, series: Characters
    let next, previous: Next

    enum CodingKeys: String, CodingKey {
        case id, title
        case resourceURI, urls, start, end, thumbnail, creators, characters, stories, comics, series, next, previous
    }
}

// MARK: - Next

struct Next: Codable {
    let resourceURI: String
    let name: String
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case textStory = "text story"
}


