//
//  TestingAppDelegate.swift
//  VivoraTests
//
//  Created by Andoni Da silva on 27/5/22.
//

import UIKit

@testable import Vivora_PRE

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.vivoraMain
        window?.rootViewController = UINavigationController(rootViewController: UIViewController())
        window?.makeKeyAndVisible()
        Logger.configure(isTest: true)
        return true
    }
}
