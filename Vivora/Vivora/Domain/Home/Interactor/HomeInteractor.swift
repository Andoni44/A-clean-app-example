//
//  HomeInteractor.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

struct HomeInteractor: HomeInteractorProtocol {
    let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    func filter(collection: CharacterListModel, byCharacterName name: String, completion: @escaping (CharacterListModel) -> Void) {
        let toRet = collection.filter { $0.name.lowercased().hasPrefix(name) }
        completion(toRet)
    }

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void) {
        repository.getCharacterList(name: name, offset: offset) { result in
            completion(result)
        }
    }
}
