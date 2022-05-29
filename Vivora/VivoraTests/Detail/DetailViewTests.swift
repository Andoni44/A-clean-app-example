//
//  DetailViewTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import XCTest
@testable import Vivora_PRE

class DetailViewTests: XCTestCase {
    var presenter: DetailPresenterProtocolMock!
    var sut: DetailView!
    var navigation: UINavigationController!

    override func setUp() {
        super.setUp()
        presenter = DetailPresenterProtocolMock()
        sut = DetailView(presenter: presenter,
                         character: TestHelper.getDetailCharacterModel())
        navigation = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }

    override func tearDown() {
        presenter = nil
        sut = nil
        navigation = nil
        super.tearDown()
    }

    func test_outlets() {
        [
            sut.descriptionTitle!,
            sut.descriptionBody!,
            sut.descriptionStack!,
            sut.comicsContainer!,
            sut.headerView!,
            sut.storiesContainer!,
            sut.eventsContainer!,
            sut.storiesCollectionViewContainer!,
            sut.storiesLabel!,
            sut.comicsCollectionContainer!,
            sut.comicsLabel!,
            sut.eventsLabel!,
            sut.eventsCollectionContainer!,
            sut.animationView!,
            sut.comicsAI,
            sut.eventsAI!,
            sut.storiesAI
        ]
            .forEach {
                XCTAssertNotNil($0)
            }
    }

    func test_viewDidLoad() {
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }

    func test_localize() {
        XCTAssertEqual(sut.descriptionTitle!.text!, "detail-description".localized)
        XCTAssertEqual(sut.eventsLabel!.text!, "detail-events".localized)
        XCTAssertEqual(sut.comicsLabel!.text!, "detail-comics".localized)
        XCTAssertEqual(sut.storiesLabel!.text!, "detail-stories".localized)
    }

    func test_child_shouldBe_none() {
        sut.displayCollectionViews(fromViewModel: .init(comics: [],
                                                        stories: [],
                                                        events: []))
        XCTAssertTrue(sut.children.isEmpty)
    }

    func test_child_shouldBe_3() {
        sut.displayCollectionViews(fromViewModel: .init(comics: [""],
                                                        stories: [""],
                                                        events: [""]))
        XCTAssertTrue(sut.children.count == 3)
    }

    func test_startAnimation() {
        sut.startAnimation()
        waitUI()
        [sut.comicsAI, sut.eventsAI, sut.storiesAI].forEach {
            XCTAssertTrue($0!.isAnimating)
        }
    }

    func test_stopAnimation() {
        sut.stopAnimation()
        waitUI()
        [sut.comicsAI, sut.eventsAI, sut.storiesAI].forEach {
            XCTAssertFalse($0!.isAnimating)
        }
    }

    func test_displaError() {
        sut.display(error: "Dummy error")
        waitUI()
        XCTAssertTrue(sut.navigationController!.view.subviews[3].isKind(of: VivoraToast.self))
    }

    func test_collectionView_numberOfSections_shouldBe_1() {
        let collectionView = generateCollection()
        XCTAssertTrue(collectionView.numberOfSections == 1)

    }

    func test_collectionView_numberOfRows_shouldBe_2() {
        let collectionView = generateCollection()
        XCTAssertNotNil(collectionView)
        XCTAssertTrue(TestHelper.numberOfRows(in: collectionView) == 2)
    }

    func test_collectionView_cellLoaded() {
        let collectionView = generateCollection()
        XCTAssertNotNil(collectionView)
        guard
            let cell = TestHelper.cellForRowAt(in: collectionView, row: 1) as? DetailCell
        else {
            XCTFail("Fail to get HomeCell")
            return
        }
        XCTAssertNotNil(cell.image)
    }

    private func generateCollection() -> UICollectionView {
        sut = DetailView(presenter: presenter,
                         character: TestHelper.getDetailCharacterModel(isEmpty: false))
        navigation = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
        sut.displayCollectionViews(fromViewModel: .init(comics: ["", ""],
                                                        stories: [""],
                                                        events: [""]))
        return sut.comicsCollectionContainer.subviews[0].subviews[0] as! UICollectionView
    }
}
