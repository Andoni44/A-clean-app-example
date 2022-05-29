//
//  HomePresenterTests.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import XCTest
@testable import Vivora_PRE

class HomePresenterTests: XCTestCase {
    var sut: HomePresenter!
    var interactor: HomeInteractorProtocolMock!
    var router: HomeRouterProtocolMock!
    var view: HomePresenterToViewProtocolMock!
    var list: CharacterListModel!

    override func setUp() {
        super.setUp()
        list = getMockCharacterListModel()
        view = HomePresenterToViewProtocolMock()
        router = HomeRouterProtocolMock()
        interactor = HomeInteractorProtocolMock()

        sut = HomePresenter(interactor: interactor,
                            router: router)
        sut.view = view
    }

    override func tearDown() {
        list = nil
        router = nil
        interactor = nil
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_dependencies_notNil() {
        [interactor!, router!, view!].forEach {
            XCTAssertNotNil($0)
        }
    }

    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.startAnimationCalled)
        XCTAssertTrue(interactor.getCharacterListNameOffsetCompletionCalled)
        XCTAssertEqual(interactor.getCharacterListNameOffsetCompletionReceivedArguments!.0, "")
        XCTAssertEqual(interactor.getCharacterListNameOffsetCompletionReceivedArguments!.1, "")
        XCTAssertEqual(interactor.getCharacterListNameOffsetCompletionCallsCount, 1)
    }

    func test_filter_byName_A() {
        interactor.filterCollectionByCharacterNameCompletionClosure = { _, _, result in
            result(self.list.filter { $0.name.lowercased().hasPrefix("a") })
        }
        sut.filter(collection: list, byCharacterName: "A")
        XCTAssertTrue(view.startFilteringCalled)
        XCTAssertTrue(interactor.filterCollectionByCharacterNameCompletionCalled)
        XCTAssertTrue(interactor.filterCollectionByCharacterNameCompletionCallsCount == 1)
        XCTAssertEqual(interactor.filterCollectionByCharacterNameCompletionReceivedArguments!.0.count, list.count)
        XCTAssertEqual(interactor.filterCollectionByCharacterNameCompletionReceivedArguments!.1, "A")
        XCTAssertTrue(view.filteredData.count == 1)
        XCTAssertTrue(view.filteredData[0].name == "A")
        XCTAssertTrue(view.hideNoResultsCalled)
        XCTAssertFalse(view.showNoResultsCalled)
    }

    func test_filter_byName_D_noResults() {
        interactor.filterCollectionByCharacterNameCompletionClosure = { _, _, result in
            result(self.list.filter { $0.name.lowercased().hasPrefix("d") })
        }
        sut.filter(collection: list, byCharacterName: "D")
        XCTAssertTrue(view.startFilteringCalled)
        XCTAssertTrue(interactor.filterCollectionByCharacterNameCompletionCalled)
        XCTAssertTrue(interactor.filterCollectionByCharacterNameCompletionCallsCount == 1)
        XCTAssertEqual(interactor.filterCollectionByCharacterNameCompletionReceivedArguments!.0.count, list.count)
        XCTAssertEqual(interactor.filterCollectionByCharacterNameCompletionReceivedArguments!.1, "D")
        XCTAssertFalse(view.hideNoResultsCalled)
        XCTAssertTrue(view.showNoResultsCalled)
    }
}
