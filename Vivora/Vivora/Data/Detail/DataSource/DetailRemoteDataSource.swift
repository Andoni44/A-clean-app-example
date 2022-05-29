//
//  DetailRemoteDataSource.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

struct DetailRemoteDataSource: DetailRemoteDataSourceProtocol {
    private let api: ApiFactoryProtocol

    init(api: ApiFactoryProtocol = ApiFactory()) {
        self.api = api
    }

    // TODO: ApiFactory with async/await

    func getCollectionsData(from character: Character,
                            completion: @escaping (Result<(comics: [ComicDTO],
                                                           events: [EventDTO],
                                                           stories: [StoryDTO]),
                                                   NetworkError>) -> Void) {
        let group = DispatchGroup()
        var serviceError: NetworkError?

        var comics: [ComicDTO] = []
        var events: [EventDTO] = []
        var stories: [StoryDTO] = []
        let comicsEndpoints: [VivoraEndPoint] = character.comicsCollection.map {
            .getComic(id: $0)
        }
        let eventsEndpoints: [VivoraEndPoint] = character.eventsCollection.map {
            .getEvent(id: $0)
        }
        let storiesEndpoints: [VivoraEndPoint] = character.storiesCollection.map {
            .getStory(id: $0)
        }

        comicsEndpoints.forEach {
            api.getData(fromEndPoint: $0) { (dtoResult: Result<ComicDTO, NetworkError>) in
                group.enter()
                switch dtoResult {
                    case .success(let comicDTO):
                        comics.append(comicDTO)
                        group.leave()
                    case .failure(let error):
                        serviceError = error
                        group.leave()
                }
            }
        }

        eventsEndpoints.forEach {
            group.enter()
            api.getData(fromEndPoint: $0) { (dtoResult: Result<EventDTO, NetworkError>) in
                switch dtoResult {
                    case .success(let eventDTO):
                        events.append(eventDTO)
                        group.leave()
                    case .failure(let error):
                        serviceError = error
                        group.leave()
                }
            }
        }


        storiesEndpoints.forEach {
            group.enter()
            api.getData(fromEndPoint: $0) { (dtoResult: Result<StoryDTO, NetworkError>) in
                switch dtoResult {
                    case .success(let storyDTO):
                        stories.append(storyDTO)
                        group.leave()
                    case .failure(let error):
                        serviceError = error
                        group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            if let error  = serviceError {
                completion(.failure(error))
            } else {
                completion(.success((comics: comics,
                                     events: events,
                                     stories: stories)))
            }
        }
    }
}
