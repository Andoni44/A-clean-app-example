//
//  HomeProtocols.swift
//  Presentation
//
//  Created by Andoni Da silva on 23/5/22.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol HomePresenterProtocol: AnyObject {
    var view: HomePresenterToViewProtocol? { get set }

    func viewDidLoad()
    func loadWith(name: String, offset: String)
    func filter(collection: CharacterListModel, byCharacterName name: String)
    func navigateTo(characterDetail: Character)
}

// sourcery: AutoMockable
protocol HomePresenterToViewProtocol: BasePresenterToViewProtocol {
    var filteredData: CharacterListModel { get set }

    func present(characterList list: CharacterListModel)
    func stopFiltering()
    func startFiltering()
    func showNoResults()
    func hideNoResults()
}

// sourcery: AutoMockable
protocol HomeViewProtocol {
    
}

// sourcery: AutoMockable
protocol HomeRouterProtocol: AnyObject {
    var view: UIViewController? { get set }

    func navigateToDetail(ofCharacter character: Character)
}
