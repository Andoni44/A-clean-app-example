//
//  DetailRepositoryTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

import XCTest
@testable import Vivora_PRE

class DetailRepositoryTests: XCTestCase {
    var sut: DetailRepository!
    var localDS: DetailLocalDataSourceProtocolMock!
    var remoteDS: DetailRemoteDataSourceProtocolMock!

    override func setUp() {
        localDS = DetailLocalDataSourceProtocolMock()
        remoteDS = DetailRemoteDataSourceProtocolMock()

        sut = DetailRepository(remoteDataSource: remoteDS,
                             localDataSource: localDS)
    }

    override func tearDown() {
        localDS = nil
        remoteDS = nil
        sut = nil
    }

    func test_getCollectionsData_success() {
        remoteDS.getCollectionsDataFromCompletionClosure = { _ , result in
            result(.success((comics: [], events: [], stories: [])))
        }

        let expectation = expectation(description: "Async work")
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel()) { result in
            switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                    expectation.fulfill()
                default:
                    expectation.fulfill()
                    break
            }
            XCTAssertTrue(self.remoteDS.getCollectionsDataFromCompletionCalled)
            XCTAssertTrue(self.remoteDS.getCollectionsDataFromCompletionCallsCount == 1)
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func test_getCollectionsData_error() {
        remoteDS.getCollectionsDataFromCompletionClosure = { _ , result in
            result(.failure(.error))
        }

        let expectation = expectation(description: "Async work")
        sut.getCollectionsData(from: TestHelper.getDetailCharacterModel()) { result in
            switch result {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                    break
                default:
                    break
            }
            XCTAssertTrue(self.remoteDS.getCollectionsDataFromCompletionCalled)
            XCTAssertTrue(self.remoteDS.getCollectionsDataFromCompletionCallsCount == 1)
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
