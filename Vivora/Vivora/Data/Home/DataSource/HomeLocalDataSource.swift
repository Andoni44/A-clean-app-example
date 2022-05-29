//
//  HomeLocalDataSource.swift
//  Vivora
//
//  Created by Andoni Da silva on 25/5/22.
//

import Foundation

struct HomeLocalDataSource: HomeLocalDataSourceProtocol {
    let defaults: UserDefaultsProtocol

    init(defaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.defaults = defaults
    }
}
