//
//  DetailInteractorTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import XCTest
@testable import Vivora_PRE

class DetailInteractorTests: XCTestCase {
    var sut: DetailInteractorProtocol!
    var repo: DetailRepositoryProtocolMock!
    var list: CharacterListModel!

    override func setUp() {
        repo = DetailRepositoryProtocolMock()
        list = TestHelper.getMockCharacterListModel()
        sut = DetailInteractor(repository: repo)
    }

    override func tearDown() {
        repo = nil
        list = nil
        sut = nil
    }

    func test_getCollectionsData_success() {
        let expectation = expectation(description: "Async work")
        repo.getCollectionsDataFromCompletionClosure  = { _, result in
            result(.success(["comics": [""], "events": [""], "stories": [""]]))
        }
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel(isEmpty: false)) { result in
            switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    expectation.fulfill()
                default:
                    break
            }
            XCTAssertTrue(self.repo.getCollectionsDataFromCompletionCalled)
            XCTAssertTrue(self.repo.getCollectionsDataFromCompletionCallsCount == 1)
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func test_getCollectionsData_error() {
        let expectation = expectation(description: "Async work")
        repo.getCollectionsDataFromCompletionClosure  = { _, result in
            result(.failure(.error))
        }
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel(isEmpty: false)) { result in
            switch result {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                default:
                    break
            }
            XCTAssertTrue(self.repo.getCollectionsDataFromCompletionCalled)
            XCTAssertTrue(self.repo.getCollectionsDataFromCompletionCallsCount == 1)
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
