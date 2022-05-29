//
//  XCTestCase+Extensions.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import XCTest

extension XCTestCase {
    func waitUI(withDelay: Double = 0) {
        let uiExpectation = expectation(description: "UI Working")
        DispatchQueue.main.asyncAfter(deadline: .now() + withDelay + 0.2) {
            uiExpectation.fulfill()
        }
        waitForExpectations(timeout: withDelay + 1, handler: nil)
    }
}
