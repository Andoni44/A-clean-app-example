//
//  Protocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

// sourcery: AutoMockable
protocol HomeInteractorProtocol {
    func filter(collection: CharacterListModel, byCharacterName name: String, completion: @escaping (CharacterListModel) -> Void)
    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void)
}
