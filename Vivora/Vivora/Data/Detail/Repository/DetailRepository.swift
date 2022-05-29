//
//  DetailRepository.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

struct DetailRepository: DetailRepositoryProtocol {
    let remoteDataSource: DetailRemoteDataSourceProtocol
    let localDataSource: DetailLocalDataSourceProtocol

    init(remoteDataSource: DetailRemoteDataSourceProtocol, localDataSource: DetailLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func getCollectionsData(from character: Character,
                            completion: @escaping (Result<[String: [String]],
                                                   NetworkError>) -> Void) {

        remoteDataSource.getCollectionsData(from: character) { results in
            switch results {
                case .success(let collection):
                    completion(.success(transformResults(collection)))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

    private func transformResults(_ results: (comics: [ComicDTO],
                                              events: [EventDTO],
                                              stories: [StoryDTO])) -> [String: [String]] {
        var toRet: [String: [String]] = [:]

        toRet["comics"] = results.comics.map {
            $0.data.results
        }
        .flatMap {
            $0
        }
        .map {
            $0.thumbnail.path.transformToHTTPS
        }

        toRet["events"] = results.events.map {
            $0.data.results
        }
        .flatMap {
            $0
        }
        .map {
            $0.thumbnail.path.transformToHTTPS
        }

        toRet["stories"] = results.stories.map {
            $0.data.results
        }
        .flatMap {
            $0
        }
        .compactMap {
            $0.thumbnail?.path.transformToHTTPS
        }
        return toRet
    }
}
