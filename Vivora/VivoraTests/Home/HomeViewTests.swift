//
//  VivoraTests.swift
//  VivoraTests
//
//  Created by Andoni Da silva on 24/5/22.
//

import XCTest
@testable import Vivora_PRE

class HomeViewTests: XCTestCase {
    var presenter: HomePresenterProtocolMock!
    var sut: HomeView!
    var navigation: UINavigationController!
    var list: CharacterListModel!
    
    override func setUp() {
        super.setUp()
        list = getMockCharacterListModel()
        presenter = HomePresenterProtocolMock()
        presenter.viewDidLoadClosure = {
            self.sut.present(characterList: self.list)
        }
        sut = HomeView(presenter: presenter)
        navigation = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }

    override func tearDown() {
        presenter = nil
        sut = nil
        navigation = nil
        list = nil
        super.tearDown()
    }

    func test_outlets() {
        [sut.scrollUpButton!, sut.animationView!, sut.noResultsLabel!, sut.searchButton!]
            .forEach {
                XCTAssertNotNil($0)
            }
    }

    func test_viewDidLoad() {
        XCTAssertTrue(presenter.viewDidLoadCalled)
        XCTAssertEqual(sut.animationView.loopMode, .loop)
        XCTAssertEqual(sut.navigationItem.searchController, sut.searchController)
        XCTAssertTrue(sut.navigationController!.navigationBar.prefersLargeTitles)
        XCTAssertTrue(sut.tableView.showsVerticalScrollIndicator)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        XCTAssertNotNil(sut.searchController.searchResultsUpdater)
        XCTAssertNotNil(sut.searchController.searchBar.delegate)
        XCTAssertFalse(sut.searchController.obscuresBackgroundDuringPresentation)
        XCTAssertTrue(sut.definesPresentationContext)
        XCTAssertTrue(sut.searchButton.isEnabled)
        XCTAssertTrue(sut.noResultsLabel.alpha == 0)
        XCTAssertTrue(sut.searchButton.alpha == 0)
        XCTAssertTrue(sut.scrollUpButton.alpha == 0)
    }

    func test_setupButton() {
        XCTAssertEqual(sut.scrollUpButton.layer.shadowColor, UIColor.lightGray.cgColor)
        XCTAssertEqual(sut.scrollUpButton.layer.shadowOpacity, 1)
        XCTAssertEqual(sut.scrollUpButton.layer.shadowOffset, CGSize(width: 20, height: 20))
        XCTAssertEqual(sut.scrollUpButton.layer.shadowRadius, 82)
        XCTAssertEqual(sut.scrollUpButton.layer.rasterizationScale, UIScreen.main.scale)
    }

    func test_searchButton() {
        tap(sut.searchButton)
        waitUI()
        XCTAssertTrue(presenter.loadWithNameOffsetCalled)
        XCTAssertFalse(sut.searchButton.isEnabled)
    }

    func test_tableViewDelegates_shouldBePointed() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
    }

    func test_numberOfRows_shouldBe() {
        XCTAssertEqual(numberOfRows(in: sut.tableView), 3)
    }

    func test_cellForRowAt_withRow0_shouldSetNameToA() {
        guard
            let cell = cellForRowAt(in: sut.tableView, row: 0) as? HomeCell
        else {
            XCTFail("Fail to get HomeCell")
            return
        }

        XCTAssertEqual(cell.label.titleLabel.text, "A")
    }

    func test_cellForRowAt_withRow1_shouldSetNameToB() {
        guard
            let cell = cellForRowAt(in: sut.tableView, row: 1) as? HomeCell
        else {
            XCTFail("Fail to get HomeCell")
            return
        }

        XCTAssertEqual(cell.label.titleLabel.text, "B")
    }

    func test_cellForRowAt_withRow2_shouldSetNameToC() {
        guard
            let cell = cellForRowAt(in: sut.tableView, row: 2) as? HomeCell
        else {
            XCTFail("Fail to get HomeCell")
            return
        }

        XCTAssertEqual(cell.label.titleLabel.text, "C")
    }

    func test_didSelectRow_withRow1() {
        didSelectRow(in: sut.tableView, row: 1)
    }

    func test_hideResults() {
        sut.hideNoResults()
        XCTAssertEqual(sut.noResultsLabel.alpha, 0)
        XCTAssertEqual(sut.searchButton.alpha, 0)
    }

    func test_showResults() {
        sut.showNoResults()
        waitUI(withDelay: 0.2)
        XCTAssertEqual(sut.noResultsLabel.alpha, 1)
        XCTAssertEqual(sut.searchButton.alpha, 1)
    }

    func test_present_characterList() {
        sut.present(characterList: list)
        waitUI()
        XCTAssertTrue(sut.searchButton.isEnabled)
    }

    func test_startAnimation() {
        sut.startAnimation()
        waitUI(withDelay: 0.2)
        XCTAssertEqual(sut.animationView.alpha, 1)
    }

    func test_stopAnimation() {
        sut.stopAnimation()
        waitUI(withDelay: 0.2)
        XCTAssertEqual(sut.animationView.alpha, 0)
    }

    func test_toast() {
        sut.display(error: "Dummy error")
        waitUI()
        XCTAssertTrue(sut.navigationController!.view.subviews[3].isKind(of: VivoraToast.self))
    }
}
