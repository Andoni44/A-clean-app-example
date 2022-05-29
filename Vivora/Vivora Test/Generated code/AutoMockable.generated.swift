// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
















class DetailInteractorProtocolMock: DetailInteractorProtocol {

    //MARK: - getCollectionsData

    var getCollectionsDataFromCompletionCallsCount = 0
    var getCollectionsDataFromCompletionCalled: Bool {
        return getCollectionsDataFromCompletionCallsCount > 0
    }
    var getCollectionsDataFromCompletionReceivedArguments: (character: Character, completion: (Result<CollectionDisplayDataModel, NetworkError>) -> Void)?
    var getCollectionsDataFromCompletionReceivedInvocations: [(character: Character, completion: (Result<CollectionDisplayDataModel, NetworkError>) -> Void)] = []
    var getCollectionsDataFromCompletionClosure: ((Character, @escaping (Result<CollectionDisplayDataModel, NetworkError>) -> Void) -> Void)?

    func getCollectionsData(from character: Character, completion: @escaping (Result<CollectionDisplayDataModel, NetworkError>) -> Void) {
        getCollectionsDataFromCompletionCallsCount += 1
        getCollectionsDataFromCompletionReceivedArguments = (character: character, completion: completion)
        getCollectionsDataFromCompletionReceivedInvocations.append((character: character, completion: completion))
        getCollectionsDataFromCompletionClosure?(character, completion)
    }

}
class DetailLocalDataSourceProtocolMock: DetailLocalDataSourceProtocol {

}
class DetailPresenterProtocolMock: DetailPresenterProtocol {
    var view: DetailPresenterToViewProtocol?

    //MARK: - viewDidLoad

    var viewDidLoadCallsCount = 0
    var viewDidLoadCalled: Bool {
        return viewDidLoadCallsCount > 0
    }
    var viewDidLoadClosure: (() -> Void)?

    func viewDidLoad() {
        viewDidLoadCallsCount += 1
        viewDidLoadClosure?()
    }

    //MARK: - getCollectionsData

    var getCollectionsDataFromCallsCount = 0
    var getCollectionsDataFromCalled: Bool {
        return getCollectionsDataFromCallsCount > 0
    }
    var getCollectionsDataFromReceivedCharacter: Character?
    var getCollectionsDataFromReceivedInvocations: [Character] = []
    var getCollectionsDataFromClosure: ((Character) -> Void)?

    func getCollectionsData(from character: Character) {
        getCollectionsDataFromCallsCount += 1
        getCollectionsDataFromReceivedCharacter = character
        getCollectionsDataFromReceivedInvocations.append(character)
        getCollectionsDataFromClosure?(character)
    }

}
class DetailPresenterToViewProtocolMock: DetailPresenterToViewProtocol {

    //MARK: - displayStaticData

    var displayStaticDataCallsCount = 0
    var displayStaticDataCalled: Bool {
        return displayStaticDataCallsCount > 0
    }
    var displayStaticDataClosure: (() -> Void)?

    func displayStaticData() {
        displayStaticDataCallsCount += 1
        displayStaticDataClosure?()
    }

    //MARK: - displayCollectionViews

    var displayCollectionViewsFromViewModelCallsCount = 0
    var displayCollectionViewsFromViewModelCalled: Bool {
        return displayCollectionViewsFromViewModelCallsCount > 0
    }
    var displayCollectionViewsFromViewModelReceivedFromViewModel: CollectionDisplayDataModel?
    var displayCollectionViewsFromViewModelReceivedInvocations: [CollectionDisplayDataModel] = []
    var displayCollectionViewsFromViewModelClosure: ((CollectionDisplayDataModel) -> Void)?

    func displayCollectionViews(fromViewModel: CollectionDisplayDataModel) {
        displayCollectionViewsFromViewModelCallsCount += 1
        displayCollectionViewsFromViewModelReceivedFromViewModel = fromViewModel
        displayCollectionViewsFromViewModelReceivedInvocations.append(fromViewModel)
        displayCollectionViewsFromViewModelClosure?(fromViewModel)
    }

    //MARK: - startAnimation

    var startAnimationCallsCount = 0
    var startAnimationCalled: Bool {
        return startAnimationCallsCount > 0
    }
    var startAnimationClosure: (() -> Void)?

    func startAnimation() {
        startAnimationCallsCount += 1
        startAnimationClosure?()
    }

    //MARK: - stopAnimation

    var stopAnimationCallsCount = 0
    var stopAnimationCalled: Bool {
        return stopAnimationCallsCount > 0
    }
    var stopAnimationClosure: (() -> Void)?

    func stopAnimation() {
        stopAnimationCallsCount += 1
        stopAnimationClosure?()
    }

    //MARK: - display

    var displayErrorCallsCount = 0
    var displayErrorCalled: Bool {
        return displayErrorCallsCount > 0
    }
    var displayErrorReceivedError: String?
    var displayErrorReceivedInvocations: [String] = []
    var displayErrorClosure: ((String) -> Void)?

    func display(error: String) {
        displayErrorCallsCount += 1
        displayErrorReceivedError = error
        displayErrorReceivedInvocations.append(error)
        displayErrorClosure?(error)
    }

}
class DetailRemoteDataSourceProtocolMock: DetailRemoteDataSourceProtocol {

    //MARK: - getCollectionsData

    var getCollectionsDataFromCompletionCallsCount = 0
    var getCollectionsDataFromCompletionCalled: Bool {
        return getCollectionsDataFromCompletionCallsCount > 0
    }
    var getCollectionsDataFromCompletionReceivedArguments: (character: Character, completion: (Result<(comics: [ComicDTO], events: [EventDTO], stories: [StoryDTO]), NetworkError>) -> Void)?
    var getCollectionsDataFromCompletionReceivedInvocations: [(character: Character, completion: (Result<(comics: [ComicDTO], events: [EventDTO], stories: [StoryDTO]), NetworkError>) -> Void)] = []
    var getCollectionsDataFromCompletionClosure: ((Character, @escaping (Result<(comics: [ComicDTO], events: [EventDTO], stories: [StoryDTO]), NetworkError>) -> Void) -> Void)?

    func getCollectionsData(from character: Character, completion: @escaping (Result<(comics: [ComicDTO], events: [EventDTO], stories: [StoryDTO]), NetworkError>) -> Void) {
        getCollectionsDataFromCompletionCallsCount += 1
        getCollectionsDataFromCompletionReceivedArguments = (character: character, completion: completion)
        getCollectionsDataFromCompletionReceivedInvocations.append((character: character, completion: completion))
        getCollectionsDataFromCompletionClosure?(character, completion)
    }

}
class DetailRepositoryProtocolMock: DetailRepositoryProtocol {

    //MARK: - getCollectionsData

    var getCollectionsDataFromCompletionCallsCount = 0
    var getCollectionsDataFromCompletionCalled: Bool {
        return getCollectionsDataFromCompletionCallsCount > 0
    }
    var getCollectionsDataFromCompletionReceivedArguments: (character: Character, completion: (Result<[String: [String]], NetworkError>) -> Void)?
    var getCollectionsDataFromCompletionReceivedInvocations: [(character: Character, completion: (Result<[String: [String]], NetworkError>) -> Void)] = []
    var getCollectionsDataFromCompletionClosure: ((Character, @escaping (Result<[String: [String]], NetworkError>) -> Void) -> Void)?

    func getCollectionsData(from character: Character, completion: @escaping (Result<[String: [String]], NetworkError>) -> Void) {
        getCollectionsDataFromCompletionCallsCount += 1
        getCollectionsDataFromCompletionReceivedArguments = (character: character, completion: completion)
        getCollectionsDataFromCompletionReceivedInvocations.append((character: character, completion: completion))
        getCollectionsDataFromCompletionClosure?(character, completion)
    }

}
class DetailRouterProtocolMock: DetailRouterProtocol {

}
class DetailViewProtocolMock: DetailViewProtocol {

}
class HomeInteractorProtocolMock: HomeInteractorProtocol {

    //MARK: - filter

    var filterCollectionByCharacterNameCompletionCallsCount = 0
    var filterCollectionByCharacterNameCompletionCalled: Bool {
        return filterCollectionByCharacterNameCompletionCallsCount > 0
    }
    var filterCollectionByCharacterNameCompletionReceivedArguments: (collection: CharacterListModel, name: String, completion: (CharacterListModel) -> Void)?
    var filterCollectionByCharacterNameCompletionReceivedInvocations: [(collection: CharacterListModel, name: String, completion: (CharacterListModel) -> Void)] = []
    var filterCollectionByCharacterNameCompletionClosure: ((CharacterListModel, String, @escaping (CharacterListModel) -> Void) -> Void)?

    func filter(collection: CharacterListModel, byCharacterName name: String, completion: @escaping (CharacterListModel) -> Void) {
        filterCollectionByCharacterNameCompletionCallsCount += 1
        filterCollectionByCharacterNameCompletionReceivedArguments = (collection: collection, name: name, completion: completion)
        filterCollectionByCharacterNameCompletionReceivedInvocations.append((collection: collection, name: name, completion: completion))
        filterCollectionByCharacterNameCompletionClosure?(collection, name, completion)
    }

    //MARK: - getCharacterList

    var getCharacterListNameOffsetCompletionCallsCount = 0
    var getCharacterListNameOffsetCompletionCalled: Bool {
        return getCharacterListNameOffsetCompletionCallsCount > 0
    }
    var getCharacterListNameOffsetCompletionReceivedArguments: (name: String, offset: String, completion: (Result<CharacterListModel, NetworkError>) -> Void)?
    var getCharacterListNameOffsetCompletionReceivedInvocations: [(name: String, offset: String, completion: (Result<CharacterListModel, NetworkError>) -> Void)] = []
    var getCharacterListNameOffsetCompletionClosure: ((String, String, @escaping (Result<CharacterListModel, NetworkError>) -> Void) -> Void)?

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void) {
        getCharacterListNameOffsetCompletionCallsCount += 1
        getCharacterListNameOffsetCompletionReceivedArguments = (name: name, offset: offset, completion: completion)
        getCharacterListNameOffsetCompletionReceivedInvocations.append((name: name, offset: offset, completion: completion))
        getCharacterListNameOffsetCompletionClosure?(name, offset, completion)
    }

}
class HomeLocalDataSourceProtocolMock: HomeLocalDataSourceProtocol {

}
class HomePresenterProtocolMock: HomePresenterProtocol {
    var view: HomePresenterToViewProtocol?

    //MARK: - viewDidLoad

    var viewDidLoadCallsCount = 0
    var viewDidLoadCalled: Bool {
        return viewDidLoadCallsCount > 0
    }
    var viewDidLoadClosure: (() -> Void)?

    func viewDidLoad() {
        viewDidLoadCallsCount += 1
        viewDidLoadClosure?()
    }

    //MARK: - loadWith

    var loadWithNameOffsetCallsCount = 0
    var loadWithNameOffsetCalled: Bool {
        return loadWithNameOffsetCallsCount > 0
    }
    var loadWithNameOffsetReceivedArguments: (name: String, offset: String)?
    var loadWithNameOffsetReceivedInvocations: [(name: String, offset: String)] = []
    var loadWithNameOffsetClosure: ((String, String) -> Void)?

    func loadWith(name: String, offset: String) {
        loadWithNameOffsetCallsCount += 1
        loadWithNameOffsetReceivedArguments = (name: name, offset: offset)
        loadWithNameOffsetReceivedInvocations.append((name: name, offset: offset))
        loadWithNameOffsetClosure?(name, offset)
    }

    //MARK: - filter

    var filterCollectionByCharacterNameCallsCount = 0
    var filterCollectionByCharacterNameCalled: Bool {
        return filterCollectionByCharacterNameCallsCount > 0
    }
    var filterCollectionByCharacterNameReceivedArguments: (collection: CharacterListModel, name: String)?
    var filterCollectionByCharacterNameReceivedInvocations: [(collection: CharacterListModel, name: String)] = []
    var filterCollectionByCharacterNameClosure: ((CharacterListModel, String) -> Void)?

    func filter(collection: CharacterListModel, byCharacterName name: String) {
        filterCollectionByCharacterNameCallsCount += 1
        filterCollectionByCharacterNameReceivedArguments = (collection: collection, name: name)
        filterCollectionByCharacterNameReceivedInvocations.append((collection: collection, name: name))
        filterCollectionByCharacterNameClosure?(collection, name)
    }

    //MARK: - navigateTo

    var navigateToCharacterDetailCallsCount = 0
    var navigateToCharacterDetailCalled: Bool {
        return navigateToCharacterDetailCallsCount > 0
    }
    var navigateToCharacterDetailReceivedCharacterDetail: Character?
    var navigateToCharacterDetailReceivedInvocations: [Character] = []
    var navigateToCharacterDetailClosure: ((Character) -> Void)?

    func navigateTo(characterDetail: Character) {
        navigateToCharacterDetailCallsCount += 1
        navigateToCharacterDetailReceivedCharacterDetail = characterDetail
        navigateToCharacterDetailReceivedInvocations.append(characterDetail)
        navigateToCharacterDetailClosure?(characterDetail)
    }

}
class HomePresenterToViewProtocolMock: HomePresenterToViewProtocol {
    var filteredData: CharacterListModel = []

    //MARK: - present

    var presentCharacterListCallsCount = 0
    var presentCharacterListCalled: Bool {
        return presentCharacterListCallsCount > 0
    }
    var presentCharacterListReceivedList: CharacterListModel?
    var presentCharacterListReceivedInvocations: [CharacterListModel] = []
    var presentCharacterListClosure: ((CharacterListModel) -> Void)?

    func present(characterList list: CharacterListModel) {
        presentCharacterListCallsCount += 1
        presentCharacterListReceivedList = list
        presentCharacterListReceivedInvocations.append(list)
        presentCharacterListClosure?(list)
    }

    //MARK: - stopFiltering

    var stopFilteringCallsCount = 0
    var stopFilteringCalled: Bool {
        return stopFilteringCallsCount > 0
    }
    var stopFilteringClosure: (() -> Void)?

    func stopFiltering() {
        stopFilteringCallsCount += 1
        stopFilteringClosure?()
    }

    //MARK: - startFiltering

    var startFilteringCallsCount = 0
    var startFilteringCalled: Bool {
        return startFilteringCallsCount > 0
    }
    var startFilteringClosure: (() -> Void)?

    func startFiltering() {
        startFilteringCallsCount += 1
        startFilteringClosure?()
    }

    //MARK: - showNoResults

    var showNoResultsCallsCount = 0
    var showNoResultsCalled: Bool {
        return showNoResultsCallsCount > 0
    }
    var showNoResultsClosure: (() -> Void)?

    func showNoResults() {
        showNoResultsCallsCount += 1
        showNoResultsClosure?()
    }

    //MARK: - hideNoResults

    var hideNoResultsCallsCount = 0
    var hideNoResultsCalled: Bool {
        return hideNoResultsCallsCount > 0
    }
    var hideNoResultsClosure: (() -> Void)?

    func hideNoResults() {
        hideNoResultsCallsCount += 1
        hideNoResultsClosure?()
    }

    //MARK: - startAnimation

    var startAnimationCallsCount = 0
    var startAnimationCalled: Bool {
        return startAnimationCallsCount > 0
    }
    var startAnimationClosure: (() -> Void)?

    func startAnimation() {
        startAnimationCallsCount += 1
        startAnimationClosure?()
    }

    //MARK: - stopAnimation

    var stopAnimationCallsCount = 0
    var stopAnimationCalled: Bool {
        return stopAnimationCallsCount > 0
    }
    var stopAnimationClosure: (() -> Void)?

    func stopAnimation() {
        stopAnimationCallsCount += 1
        stopAnimationClosure?()
    }

    //MARK: - display

    var displayErrorCallsCount = 0
    var displayErrorCalled: Bool {
        return displayErrorCallsCount > 0
    }
    var displayErrorReceivedError: String?
    var displayErrorReceivedInvocations: [String] = []
    var displayErrorClosure: ((String) -> Void)?

    func display(error: String) {
        displayErrorCallsCount += 1
        displayErrorReceivedError = error
        displayErrorReceivedInvocations.append(error)
        displayErrorClosure?(error)
    }

}
class HomeRemoteDataSourceProtocolMock: HomeRemoteDataSourceProtocol {

    //MARK: - getCharacterList

    var getCharacterListNameOffsetCompletionCallsCount = 0
    var getCharacterListNameOffsetCompletionCalled: Bool {
        return getCharacterListNameOffsetCompletionCallsCount > 0
    }
    var getCharacterListNameOffsetCompletionReceivedArguments: (name: String, offset: String, completion: (Result<CharactersListDTO, NetworkError>) -> Void)?
    var getCharacterListNameOffsetCompletionReceivedInvocations: [(name: String, offset: String, completion: (Result<CharactersListDTO, NetworkError>) -> Void)] = []
    var getCharacterListNameOffsetCompletionClosure: ((String, String, @escaping (Result<CharactersListDTO, NetworkError>) -> Void) -> Void)?

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharactersListDTO, NetworkError>) -> Void) {
        getCharacterListNameOffsetCompletionCallsCount += 1
        getCharacterListNameOffsetCompletionReceivedArguments = (name: name, offset: offset, completion: completion)
        getCharacterListNameOffsetCompletionReceivedInvocations.append((name: name, offset: offset, completion: completion))
        getCharacterListNameOffsetCompletionClosure?(name, offset, completion)
    }

}
class HomeRepositoryProtocolMock: HomeRepositoryProtocol {

    //MARK: - getCharacterList

    var getCharacterListNameOffsetCompletionCallsCount = 0
    var getCharacterListNameOffsetCompletionCalled: Bool {
        return getCharacterListNameOffsetCompletionCallsCount > 0
    }
    var getCharacterListNameOffsetCompletionReceivedArguments: (name: String, offset: String, completion: (Result<CharacterListModel, NetworkError>) -> Void)?
    var getCharacterListNameOffsetCompletionReceivedInvocations: [(name: String, offset: String, completion: (Result<CharacterListModel, NetworkError>) -> Void)] = []
    var getCharacterListNameOffsetCompletionClosure: ((String, String, @escaping (Result<CharacterListModel, NetworkError>) -> Void) -> Void)?

    func getCharacterList(name: String, offset: String, completion: @escaping (Result<CharacterListModel, NetworkError>) -> Void) {
        getCharacterListNameOffsetCompletionCallsCount += 1
        getCharacterListNameOffsetCompletionReceivedArguments = (name: name, offset: offset, completion: completion)
        getCharacterListNameOffsetCompletionReceivedInvocations.append((name: name, offset: offset, completion: completion))
        getCharacterListNameOffsetCompletionClosure?(name, offset, completion)
    }

}
class HomeRouterProtocolMock: HomeRouterProtocol {
    var view: UIViewController?

    //MARK: - navigateToDetail

    var navigateToDetailOfCharacterCallsCount = 0
    var navigateToDetailOfCharacterCalled: Bool {
        return navigateToDetailOfCharacterCallsCount > 0
    }
    var navigateToDetailOfCharacterReceivedCharacter: Character?
    var navigateToDetailOfCharacterReceivedInvocations: [Character] = []
    var navigateToDetailOfCharacterClosure: ((Character) -> Void)?

    func navigateToDetail(ofCharacter character: Character) {
        navigateToDetailOfCharacterCallsCount += 1
        navigateToDetailOfCharacterReceivedCharacter = character
        navigateToDetailOfCharacterReceivedInvocations.append(character)
        navigateToDetailOfCharacterClosure?(character)
    }

}
class HomeViewProtocolMock: HomeViewProtocol {

}
