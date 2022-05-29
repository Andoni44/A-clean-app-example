//
//  DetailPresenter.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailPresenterToViewProtocol?
    let interactor: DetailInteractorProtocol
    let router: DetailRouterProtocol

    init(interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        view?.startAnimation()
        view?.displayStaticData()
    }

    func getCollectionsData(from character: Character) {
        interactor.getCollectionsData(from: character) { [view] result in
            switch result {
                case .success(let viewModel):
                    view?.stopAnimation()
                    view?.displayCollectionViews(fromViewModel: viewModel)
                case .failure(let error):
                    view?.stopAnimation()
                    view?.display(error: error.errorDescription ?? "Error")
            }
        }
    }
}
