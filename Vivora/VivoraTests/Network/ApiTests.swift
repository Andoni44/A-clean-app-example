//
//  ApiTests.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import XCTest
@testable import Vivora_PRE

class ApiTests: XCTestCase {
    var mockURLSession: MockURLSession!
    var sut: ApiFactoryProtocol!
    let url = "https://gateway.marvel.com/v1/public/characters?apikey=b08158b5861496ae6074d19fd8013401&hash=7f597f7d143cee53216a3bdae8f492ba&offset=1&limit=15&ts=44"

    override func setUp() {
        mockURLSession = MockURLSession()
        sut = ApiFactory(session: mockURLSession)
    }

    func test_request_count() {
        sut.getData(fromEndPoint: VivoraEndPoint.getDetail(characterID: "0")) { (_ : Result<CharactersListDTO, NetworkError>) in

        }
        XCTAssertTrue(mockURLSession.dataTaskCallCount == 1)
    }

    func test_request_endpoint() {
        sut.getData(fromEndPoint: VivoraEndPoint.getCharacters(nameStart: "", limit: "15", offset: "1")) { (_ : Result<CharactersListDTO, NetworkError>) in

        }
        XCTAssertEqual(mockURLSession.dataTaskArgsRequest.first!.url!.absoluteString, url)
    }
}
