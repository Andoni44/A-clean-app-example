//
//  Main.swift
//  Vivora
//
//  Created by Andoni Da silva on 27/5/22.
//

import UIKit

let appDelegate: AnyClass = NSClassFromString("AppDelegateMock") ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegate))
