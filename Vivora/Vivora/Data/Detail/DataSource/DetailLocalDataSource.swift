//
//  DetailLocalDataSource.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

struct DetailLocalDataSource: DetailLocalDataSourceProtocol {
    let defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }
}
