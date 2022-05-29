//
//  ComicDTO.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// MARK: - ComicDTO
struct ComicDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: ComicData
}

// MARK: - DataClass
struct ComicData: Codable {
    let offset, limit, total, count: Int
    let results: [ComicResult]
}

// MARK: - ComicResult

struct ComicResult: Codable {
    let id, digitalID: Int
    let title: String
    let issueNumber: Int
    let isbn, upc, diamondCode, ean: String
    let issn, format: String
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants: [Series]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber
        case isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem

struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - Price

struct Price: Codable {
    let type: String
    let price: Double
}

// MARK: - TextObject

struct TextObject: Codable {
    let type, language, text: String
}
