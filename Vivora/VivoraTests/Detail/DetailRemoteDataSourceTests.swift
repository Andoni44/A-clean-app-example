//
//  DetailRemoteDataSourceTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import XCTest
@testable import Vivora_PRE

class DetailRemoteDataSourceTests: XCTestCase {
    var sut: DetailRemoteDataSource!
    var apiFacotry: ApiFactoryProtocol!
    var mockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        apiFacotry = ApiFactory(session: mockURLSession)
        sut = DetailRemoteDataSource(api: apiFacotry)
    }

    override func tearDown() {
        apiFacotry = nil
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func test_getCollectionsData_comics_2() {
        let expectation = expectation(description: "Handle results")

        sut.getCollectionsData(from: .init(id: 0,
                                           image: "",
                                           name: "",
                                           description: "",
                                           comicsCollection: ["", ""],
                                           storiesCollection: [],
                                           eventsCollection:  [])) { result in
            switch result {
                case .success(let dto):
                    XCTAssertNotNil(dto)
                    expectation.fulfill()
                default:
                    XCTFail()
                    expectation.fulfill()
                    break
            }
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            getData(from: "comicDTO.json"), TestHelper.response(statusCode: 200), nil
        )
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 2)
    }

    func test_getCollectionsData_comics_1() {
        let expectation = expectation(description: "Handle results")

        sut.getCollectionsData(from: .init(id: 0,
                                           image: "",
                                           name: "",
                                           description: "",
                                           comicsCollection: [""],
                                           storiesCollection: [],
                                           eventsCollection:  [])) { result in
            switch result {
                case .success(let dto):
                    XCTAssertNotNil(dto)
                    expectation.fulfill()
                default:
                    XCTFail()
                    expectation.fulfill()
                    break
            }
        }

        mockURLSession.dataTaskArgsCompletionHandler.first?(
            getData(from: "comicDTO.json"), TestHelper.response(statusCode: 200), nil
        )
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 1)
    }

    func test_getCollectionsData_all() {
        let expectation = expectation(description: "Handle results")

        sut.getCollectionsData(from: .init(id: 0,
                                           image: "",
                                           name: "",
                                           description: "",
                                           comicsCollection: [""],
                                           storiesCollection: [""],
                                           eventsCollection:  [""])) { result in
            switch result {
                case .success(let dto):
                    XCTAssertNotNil(dto)
                    expectation.fulfill()
                default:
                    XCTFail()
                    expectation.fulfill()
                    break
            }
        }

        for (i, json) in ["comicDTO.json", "eventDTO.json", "storyDTO.json"].enumerated() {
            mockURLSession.dataTaskArgsCompletionHandler[i](
                getData(from: json), TestHelper.response(statusCode: 200), nil
            )
        }

        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 3)
    }

    func test_getCollectionsData_error() {
        let expectation = expectation(description: "Handle results")

        sut.getCollectionsData(from: .init(id: 0,
                                           image: "",
                                           name: "",
                                           description: "",
                                           comicsCollection: [""],
                                           storiesCollection: [],
                                           eventsCollection:  [])) { result in
            switch result {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                default:
                    XCTFail()
                    expectation.fulfill()
                    break
            }
        }
        mockURLSession.dataTaskArgsCompletionHandler[0](
            getData(from: "comicDTO.json"), TestHelper.response(statusCode: 409), nil
        )
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 1)
    }

    private func getData(from fileName: String) -> Data {
        let bundle = Bundle(for: HomeRemoteDataSourceTests.self)
        return bundle.decode(fileName)
    }
}
