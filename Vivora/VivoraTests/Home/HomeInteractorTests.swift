//
//  HomeInteractorTests.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import Foundation

import XCTest
@testable import Vivora_PRE

class HomeInteractorTests: XCTestCase {
    var sut: HomeInteractorProtocol!
    var repo: HomeRepositoryProtocolMock!
    var list: CharacterListModel!

    override func setUp() {
        repo = HomeRepositoryProtocolMock()
        list = TestHelper.getMockCharacterListModel()
        sut = HomeInteractor(repository: repo)
    }

    override func tearDown() {
        repo = nil
        list = nil
        sut = nil
    }

    func test_repoIs_notNil() {
        XCTAssertNotNil(repo)
    }

    func test_filter_withResults() {
        let expectation = expectation(description: "Handle results")
        sut.filter(collection: list, byCharacterName: "a") { response in
            XCTAssertTrue(response.count == 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }

    func test_filter_withNoResults() {
        let expectation = expectation(description: "Handle results")
        sut.filter(collection: list, byCharacterName: "H") { response in
            XCTAssertTrue(response.count == 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }

    func test_getCharacterList_withResults() {
        repo.getCharacterListNameOffsetCompletionClosure = { _, _, result in
            result(.success(self.list.filter{ $0.name.lowercased().hasPrefix("a") }))
        }
        let expectation = expectation(description: "Handle results")
        sut.getCharacterList(name: "A", offset: "1") { _ in
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCalled)
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCallsCount == 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }

    func test_getCharacterList_withNoResults() {
        repo.getCharacterListNameOffsetCompletionClosure = { _, _, result in
            result(.success(self.list.filter{ $0.name.lowercased().hasPrefix("cc") }))
        }
        let expectation = expectation(description: "Handle results")
        sut.getCharacterList(name: "CC", offset: "1") { _ in
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCalled)
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCallsCount == 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.01)
    }
}
