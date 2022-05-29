//
//  TestHelper.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

@testable import Vivora_PRE


// MARK: Test Buttons

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}


// MARK: - Test tables

func numberOfRows(in tableView: UITableView, section: Int = 0) -> Int? {
    tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)
}

func cellForRowAt(in tableView: UITableView, row: Int, section: Int = 0) -> UITableViewCell? {
    tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: row, section: section))
}

func didSelectRow(in tableView: UITableView, row: Int, section: Int = 0) {
    tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: row, section: section))
}

// MARK: - Dummy data

func getMockCharacterListModel() -> CharacterListModel {
    return [
        .init(id: 0, image: "", name: "A", description: "",
              comicsCollection: [], storiesCollection: [], eventsCollection: []),
        .init(id: 1, image: "", name: "B", description: "",
              comicsCollection: [], storiesCollection: [], eventsCollection: []),
        .init(id: 2, image: "", name: "C", description: "",
              comicsCollection: [], storiesCollection: [], eventsCollection: []),
    ]
}

// MARK: - Fake HTTP response

func response(statusCode: Int) -> HTTPURLResponse {
    HTTPURLResponse(url: URL(string: "http://DUMMY")!,
                    statusCode: statusCode,
                    httpVersion: nil,
                    headerFields: nil)!
}

func decodeFrom<T>(data: Data) -> T where T: Codable {
    let decoder = JSONDecoder()
    return try! decoder.decode(T.self, from: data)
}
