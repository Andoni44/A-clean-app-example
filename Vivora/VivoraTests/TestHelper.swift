//
//  TestHelper.swift
//  Tests
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

@testable import Vivora_PRE

enum TestHelper {

    // MARK: Test Buttons

    static func tap(_ button: UIButton) {
        button.sendActions(for: .touchUpInside)
    }


    // MARK: Test tables

    static func numberOfRows(in tableView: UITableView, section: Int = 0) -> Int? {
        tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0)
    }

    static func numberOfRows(in collectionView: UICollectionView, section: Int = 0) -> Int? {
        collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section)
    }

    static func cellForRowAt(in tableView: UITableView, row: Int, section: Int = 0) -> UITableViewCell? {
        tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: row, section: section))
    }

    static func cellForRowAt(in collectionView: UICollectionView, row: Int, section: Int = 0) -> UICollectionViewCell? {
        collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(row: row, section: section))
    }

    static func didSelectRow(in tableView: UITableView, row: Int, section: Int = 0) {
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: row, section: section))
    }

    // MARK: Dummy data

    static func getMockCharacterListModel() -> CharacterListModel {
        return [
            .init(id: 0, image: "", name: "A", description: "",
                  comicsCollection: [], storiesCollection: [], eventsCollection: []),
            .init(id: 1, image: "", name: "B", description: "",
                  comicsCollection: [], storiesCollection: [], eventsCollection: []),
            .init(id: 2, image: "", name: "C", description: "",
                  comicsCollection: [], storiesCollection: [], eventsCollection: []),
        ]
    }

    static func getDetailCharacterModel(isEmpty: Bool = true) -> Character {
        .init(id: 0,
              image: "",
              name: "",
              description: "",
              comicsCollection: isEmpty ? [] : ["http://DUMMY"],
              storiesCollection: isEmpty ? [] : ["http://DUMMY"],
              eventsCollection: isEmpty ? [] : ["http://DUMMY"])
    }

    // MARK: Fake HTTP response

    static func response(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://DUMMY")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)!
    }

    static func decodeFrom<T>(data: Data) -> T where T: Codable {
        let decoder = JSONDecoder()
        return try! decoder.decode(T.self, from: data)
    }
}
