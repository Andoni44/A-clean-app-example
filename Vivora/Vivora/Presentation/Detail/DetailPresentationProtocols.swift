//
//  DetailProtocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

// sourcery: AutoMockable
protocol DetailViewProtocol: AnyObject {}

// sourcery: AutoMockable
protocol DetailPresenterProtocol: AnyObject {
    var view: DetailPresenterToViewProtocol? { get set }

    func viewDidLoad()
    func getCollectionsData(from character: Character)
}

// sourcery: AutoMockable
protocol DetailRouterProtocol {

}

// sourcery: AutoMockable
protocol DetailPresenterToViewProtocol: BasePresenterToViewProtocol {
    func displayStaticData()
    func displayCollectionViews(fromViewModel: CollectionDisplayDataModel)
}
