//
//  AppDelegate.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import UIKit
import CoreData

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let home = HomeRouter.startHomeModule()
        window?.backgroundColor = UIColor.vivoraMain
        window?.rootViewController = UINavigationController(rootViewController: home)
        window?.makeKeyAndVisible()
        initLog()
        return true
    }
}

// MA

private extension AppDelegate {
    func initLog() {
        Logger.configure()
    }
}
