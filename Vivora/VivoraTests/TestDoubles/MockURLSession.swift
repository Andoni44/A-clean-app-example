//
//  MockURLSession.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import Foundation
@testable import Vivora_PRE

final class MockURLSession: URLSessionProtocol {

    // MARK: Spy properties

    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    var dataTaskArgsCompletionHandler: [(Data?, URLResponse?, Error?) -> Void] = []


    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        dataTaskArgsCompletionHandler.append(completionHandler)
        return DummyURLSessionDataTask()
    }

    // MARK: - Provides a do-nothing version of the the resume() method

    private final class DummyURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
}
