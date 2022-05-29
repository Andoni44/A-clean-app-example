//
//  HomeRouterTests.swift
//  Tests
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

import XCTest
@testable import Vivora_PRE

class HomeRouterTests: XCTestCase {
    var sut: HomeRouter!
    var navigation: UINavigationController!
    var delegate: UIApplicationDelegate!
    var viewController: UIViewController!
    
    override func setUp() {
        sut = HomeRouter()
        viewController =  UIViewController()
        navigation = UINavigationController(rootViewController: viewController)
        sut.view = viewController
        delegate = UIApplication.shared.delegate!
        delegate.window!?.rootViewController = navigation
        waitUI()
    }

    override func tearDown() {
        viewController = nil
        navigation = nil
        delegate = nil
        viewController = nil
    }

    func test_navigateToDetail() {
        sut.navigateToDetail(ofCharacter: TestHelper.getDetailCharacterModel())
        waitUI()
        XCTAssertTrue(navigation!.topViewController!.isKind(of: DetailView.self))
    }
}
