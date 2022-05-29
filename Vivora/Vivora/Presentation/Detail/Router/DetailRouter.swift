//
//  DetailRouter.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation
import UIKit

struct DetailRouter {
    static func startDetailModule(withCharacter character: Character) -> UIViewController {
        let remoteDS: DetailRemoteDataSourceProtocol = DetailRemoteDataSource()
        let localDS: DetailLocalDataSourceProtocol = DetailLocalDataSource()
        let repository: DetailRepositoryProtocol = DetailRepository(remoteDataSource: remoteDS,
                                                                localDataSource: localDS)
        let interactor: DetailInteractorProtocol = DetailInteractor(repository: repository)
        let router: DetailRouterProtocol = DetailRouter()
        let presenter: DetailPresenterProtocol = DetailPresenter(interactor: interactor, router: router)

        let view: DetailViewProtocol & DetailPresenterToViewProtocol = DetailView(presenter: presenter,
                                                                                  character: character)
        presenter.view = view
        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {

}
