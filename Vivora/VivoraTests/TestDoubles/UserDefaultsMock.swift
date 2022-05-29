//
//  UserDefaultsMock.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

@testable import Vivora_PRE

final class USerDefaultsMock: UserDefaultsProtocol {
    var integers: [String: Int] = [:]

    func set(_ value: Int, forKey defaultsName: String) {
        integers[defaultsName] = value
    }

    func integer(forKey defaultName: String) -> Int {
        integers[defaultName] ?? 0
    }
}
