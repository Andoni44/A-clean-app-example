//
//  DomainProtocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// sourcery: AutoMockable
protocol DetailInteractorProtocol {
    func getCollectionsData(from character: Character, completion: @escaping (Result<CollectionDisplayDataModel, NetworkError>) -> Void)
}
