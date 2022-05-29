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
        list = getMockCharacterListModel()
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
        sut.filter(collection: list, byCharacterName: "a") { response in
            XCTAssertTrue(response.count == 1)
        }
    }

    func test_filter_withNoResults() {
        sut.filter(collection: list, byCharacterName: "H") { response in
            XCTAssertTrue(response.count == 0)
        }
    }

    func test_getCharacterList_withResults() {
        repo.getCharacterListNameOffsetCompletionClosure = { _, _, result in
            result(.success(self.list.filter{ $0.name.lowercased().hasPrefix("a") }))
        }
        sut.getCharacterList(name: "A", offset: "1") { _ in
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCalled)
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCallsCount == 1)
        }
    }

    func test_getCharacterList_withNoResults() {
        repo.getCharacterListNameOffsetCompletionClosure = { _, _, result in
            result(.success(self.list.filter{ $0.name.lowercased().hasPrefix("cc") }))
        }
        sut.getCharacterList(name: "CC", offset: "1") { _ in
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCalled)
            XCTAssertTrue(self.repo.getCharacterListNameOffsetCompletionCallsCount == 1)
        }
    }
}
