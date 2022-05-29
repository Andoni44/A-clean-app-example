//
//  HomeRemoteDataSourceTests.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import Foundation

import XCTest
@testable import Vivora_PRE

class HomeRemoteDataSourceTests: XCTestCase {
    var sut: HomeRemoteDataSource!
    var apiFacotry: ApiFactoryProtocol!
    var mockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        apiFacotry = ApiFactory(session: mockURLSession)
        sut = HomeRemoteDataSource(api: apiFacotry)
    }

    override func tearDown() {
        apiFacotry = nil
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func test_getCharacterList_withoutError() {
        let expectation = expectation(description: "Handle results")

        sut.getCharacterList(name: "A", offset: "1") {  result in
            switch result {
                case .success(let dto):
                    XCTAssertNotNil(dto)
                    expectation.fulfill()
                case .failure:
                    XCTFail()
            }
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            getData(from: "listDTO.json"), TestHelper.response(statusCode: 200), nil
        )
        waitForExpectations(timeout: 0.01)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 1)
    }

    func test_getCharacterList_withError() {
        let expectation = expectation(description: "Handle results")

        sut.getCharacterList(name: "A", offset: "1") {  result in
            switch result {
                case .success:
                    XCTFail()
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
            }
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            getData(from: "listDTO.json"), TestHelper.response(statusCode: 404), NetworkError.auth
        )
        waitForExpectations(timeout: 0.01)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 1)
    }

    private func getData(from fileName: String) -> Data {
        let bundle = Bundle(for: HomeRemoteDataSourceTests.self)
        return bundle.decode(fileName)
    }
}

