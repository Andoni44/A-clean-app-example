//
//  HomeProtocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

// sourcery: AutoMockable
protocol HomeRepositoryProtocol {
    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void)
}

// sourcery: AutoMockable
protocol HomeRemoteDataSourceProtocol {
    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharactersListDTO, NetworkError>) -> Void)
}

// sourcery: AutoMockable
protocol HomeLocalDataSourceProtocol {
    
}
