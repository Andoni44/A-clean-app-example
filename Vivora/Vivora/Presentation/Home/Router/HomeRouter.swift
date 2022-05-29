//
//  HomeRouter.swift
//  Presentation
//
//  Created by Andoni Da silva on 23/5/22.
//

import Foundation
import UIKit

final class HomeRouter {
    var view: UIViewController?

    static func startHomeModule() -> UIViewController {
        let remoteDS: HomeRemoteDataSourceProtocol = HomeRemoteDataSource()
        let localDS: HomeLocalDataSourceProtocol = HomeLocalDataSource()

        let repository: HomeRepositoryProtocol = HomeRepository(remoteDataSource: remoteDS,
                                                                localDataSource: localDS)

        let interactor: HomeInteractorProtocol = HomeInteractor(repository: repository)

        let router: HomeRouterProtocol = HomeRouter()

        let presenter: HomePresenterProtocol = HomePresenter(interactor: interactor,
                                                             router: router)

        let view: HomeViewProtocol & HomePresenterToViewProtocol = HomeView(presenter: presenter)
        presenter.view = view
        guard let view = view as? UIViewController else { return UIViewController() }
        router.view = view
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToDetail(ofCharacter character: Character) {
        let view = DetailRouter.startDetailModule(withCharacter: character) 
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
