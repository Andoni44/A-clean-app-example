//
//  HelperTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import XCTest
@testable import Vivora_PRE

class HelperTests: XCTestCase {
    func test_getHash() {
        XCTAssertEqual(Helper.generateHash(withPublicKey: BuildConfiguration.shared.publicKey, andPrivateKey: BuildConfiguration.shared.privateKey), "7f597f7d143cee53216a3bdae8f492ba")
    }

    func test_decode() {
        let expectation = expectation(description: "Async work")
        Helper.decode(getData(from: "comicDTO.json")) { (dto: ComicDTO) in
            XCTAssertNotNil(dto)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }

    private func getData(from fileName: String) -> Data {
        let bundle = Bundle(for: HomeRemoteDataSourceTests.self)
        return bundle.decode(fileName)
    }
}
