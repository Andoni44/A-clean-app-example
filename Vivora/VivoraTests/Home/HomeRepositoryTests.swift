//
//  HomeRepositoryTests.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import Foundation

import XCTest
@testable import Vivora_PRE

class HomeRepositoryTests: XCTestCase {
    var sut: HomeRepository!
    var localDS: HomeLocalDataSourceProtocolMock!
    var remoteDS: HomeRemoteDataSourceProtocolMock!

    override func setUp() {
        localDS = HomeLocalDataSourceProtocolMock()
        remoteDS = HomeRemoteDataSourceProtocolMock()

        sut = HomeRepository(remoteDataSource: remoteDS,
                             localDataSource: localDS)
    }

    func test_dependencies_notNil() {
        [localDS!, remoteDS!].forEach {
            XCTAssertNotNil($0)
        }
    }

    func test_getCharacterList_withResults() {
        sut.getCharacterList(name: "A", offset: "1") { result in
            XCTAssertTrue(self.remoteDS.getCharacterListNameOffsetCompletionCalled)
            XCTAssertEqual(self.remoteDS.getCharacterListNameOffsetCompletionCallsCount, 1)
        }
    }

    func test_getCharacterList_withNoResults() {
        sut.getCharacterList(name: "AA", offset: "1") { result in
            XCTAssertTrue(self.remoteDS.getCharacterListNameOffsetCompletionCalled)
            XCTAssertEqual(self.remoteDS.getCharacterListNameOffsetCompletionCallsCount, 1)
        }
    }
}
