//
//  DetailInteractor.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

struct DetailInteractor: DetailInteractorProtocol {
    let repository: DetailRepositoryProtocol

    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }

    func getCollectionsData(from character: Character,
                            completion: @escaping (Result<CollectionDisplayDataModel, NetworkError>) -> Void) {
        repository.getCollectionsData(from: character) { result in
            switch result {
                case .success(let data):
                    completion(.success(.init(comics: data["comics"],
                                              stories: data["stories"],
                                              events: data["events"])))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
