//
//  CharacterListModel.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

struct Character {
    let id: Int
    let image: String
    let name: String
    let description: String
    let comicsCollection, storiesCollection, eventsCollection: [String]
}

typealias CharacterListModel = [Character]
