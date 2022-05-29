//
//  DetailPresenterTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import XCTest
@testable import Vivora_PRE

class DetailPresenterTests: XCTestCase {
    var sut: DetailPresenter!
    var interactor: DetailInteractorProtocolMock!
    var router: DetailRouterProtocolMock!
    var view: DetailPresenterToViewProtocolMock!

    override func setUp() {
        super.setUp()
        view = DetailPresenterToViewProtocolMock()
        router = DetailRouterProtocolMock()
        interactor = DetailInteractorProtocolMock()

        sut = DetailPresenter(interactor: interactor,
                            router: router)
        sut.view = view
    }

    override func tearDown() {
        router = nil
        interactor = nil
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(view.startAnimationCalled)
        XCTAssertTrue(view.displayStaticDataCalled)
        XCTAssertTrue(view.startAnimationCallsCount == 1)
        XCTAssertTrue(view.displayStaticDataCallsCount == 1)
    }

    func test_getCollectionData_success() {
        interactor.getCollectionsDataFromCompletionClosure = { _, result in
            result(.success(.init(comics: [""],
                                  stories: [],
                                  events: [])))
        }
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel())
        XCTAssertTrue(interactor.getCollectionsDataFromCompletionCalled)
        XCTAssertTrue(interactor.getCollectionsDataFromCompletionCallsCount == 1)
        XCTAssertTrue(view.stopAnimationCalled)
        XCTAssertTrue(view.stopAnimationCallsCount == 1)
        XCTAssertTrue(view.displayCollectionViewsFromViewModelCalled)
        XCTAssertTrue(view.displayCollectionViewsFromViewModelCallsCount == 1)
    }

    func test_getCollectionData_failure() {
        interactor.getCollectionsDataFromCompletionClosure = { _, result in
            result(.failure(.error))
        }
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel())
        XCTAssertTrue(interactor.getCollectionsDataFromCompletionCalled)
        XCTAssertTrue(interactor.getCollectionsDataFromCompletionCallsCount == 1)
        XCTAssertTrue(view.stopAnimationCalled)
        XCTAssertTrue(view.stopAnimationCallsCount == 1)
        XCTAssertTrue(view.displayErrorCalled)
        XCTAssertTrue(view.displayErrorCallsCount == 1)
    }
}
