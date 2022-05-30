//
//  HomeRepository.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

struct HomeRepository: HomeRepositoryProtocol {
    let remoteDataSource: HomeRemoteDataSourceProtocol
    let localDataSource: HomeLocalDataSourceProtocol

    init(remoteDataSource: HomeRemoteDataSourceProtocol, localDataSource: HomeLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void) {
        remoteDataSource.getCharacterList(name: name, offset: offset) { characterListResult in
            switch characterListResult {
                case .success(let dto):
                    completion(.success(dtoToDomain(dto: dto)))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

// MARK: - Inner methods

private extension HomeRepository {
    func dtoToDomain(dto: CharactersListDTO) -> CharacterListModel {
        return dto.data.results.map {
            let comics: [String] = $0.comics.items.map {
                $0.resourceURI.extract(withRegex: "(/[0-9]+)").dropFirst().lowercased()
            }
            let events: [String] = $0.events.items.map {
                $0.resourceURI.extract(withRegex: "(/[0-9]+)").dropFirst().lowercased()
            }
            let stories: [String] = $0.stories.items.map {
                $0.resourceURI.extract(withRegex: "(/[0-9]+)").dropFirst().lowercased()
            }
            return Character(id: $0.id,
                             image: $0.thumbnail.path.transformToHTTPS + ImageExtension.landscapeLarge.value,
                             name: $0.name,
                             description: $0.resultDescription,
                             comicsCollection: comics,
                             storiesCollection: stories,
                             eventsCollection: events)
        }
    }
}
