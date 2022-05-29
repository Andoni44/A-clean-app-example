//
//  UserDefaultsProtocol.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultsName: String)
    func integer(forKey defaultName: String) -> Int
}

extension UserDefaults: UserDefaultsProtocol {}
