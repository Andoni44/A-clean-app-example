//
//  HomePresenter.swift
//  Presentation
//
//  Created by Andoni Da silva on 23/5/22.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomePresenterToViewProtocol?
    let interactor: HomeInteractorProtocol
    let router: HomeRouterProtocol

    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.startAnimation()
        loadWith(name: "", offset: "")
    }

    func navigateTo(characterDetail: Character) {
        router.navigateToDetail(ofCharacter: characterDetail)
    }

    func filter(collection: CharacterListModel, byCharacterName name: String) {
        guard !name.isEmpty
        else {
            view?.stopFiltering()
            view?.filteredData = []
            view?.hideNoResults()
            return
        }
        view?.startFiltering()
        interactor.filter(collection: collection, byCharacterName: name) { [weak self] result in
            self?.view?.filteredData = result
            self?.hideNoResultslabel(result)
        }
    }

    func loadWith(name: String, offset: String) {
        interactor.getCharacterList(name: name, offset: offset, completion: { [weak self] result in
            switch result {
                case .success(let characters):
                    self?.view?.stopAnimation()
                    self?.view?.present(characterList: characters)
                    self?.hideNoResultslabel(characters)
                case .failure(let error):
                    self?.view?.stopAnimation()
                    self?.view?.display(error: error.errorDescription ?? "Error")
            }
        })
    }
}

// MARK: - Inner methods

private extension HomePresenter {
    func hideNoResultslabel(_ result: CharacterListModel) {
        if result.isEmpty {
            view?.showNoResults()
        } else {
            view?.hideNoResults()
        }
    }
}
