//
//  Bundle+decode.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> Data {
        // 1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        //2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        // 3. Return data
        return data
    }
}
