//
//  DetailLocalDataSource.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

struct DetailLocalDataSource: DetailLocalDataSourceProtocol {
    let defaults: UserDefaultsProtocol

    init(defaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.defaults = defaults
    }
}
