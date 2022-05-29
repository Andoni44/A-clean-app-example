//
//  HomeRemoteDataSource.swift
//  Vivora
//
//  Created by Andoni Da silva on 25/5/22.
//

import Foundation

struct HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    private let api: ApiFactoryProtocol

    init(api: ApiFactoryProtocol = ApiFactory()) {
        self.api = api
    }

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharactersListDTO, NetworkError>) -> Void) {
        api.getData(fromEndPoint: VivoraEndPoint.getCharacters(nameStart: name, offset: offset)) { (listResult: Result<CharactersListDTO, NetworkError>) in
            completion(listResult)
        }
    }
}
