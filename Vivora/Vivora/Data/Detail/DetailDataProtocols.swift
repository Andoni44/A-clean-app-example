//
//  DetailDataProtocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// sourcery: AutoMockable
protocol DetailRepositoryProtocol {
    func getCollectionsData(from character: Character, completion: @escaping (Result<[String: [String]], NetworkError>) -> Void)
}

// sourcery: AutoMockable
protocol DetailRemoteDataSourceProtocol {
    func getCollectionsData(from character: Character,
                            completion: @escaping (Result<(comics: [ComicDTO], events: [EventDTO], stories: [StoryDTO]), NetworkError>) -> Void)
}

// sourcery: AutoMockable
protocol DetailLocalDataSourceProtocol {

}
