//
//  String+Extensios.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

extension String {
    func extract(withRegex pattern: String) -> String {
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return ""
        }
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        
        guard let match = matches.first else { return "" }
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return "" }
        
        let capturedGroupIndex = match.range(at: 0)
        let matchedString = (self as NSString).substring(with: capturedGroupIndex)
        return matchedString
    }

    var transformToHTTPS: String {
        self.replacingOccurrences(of: "http", with: "https")
    }

    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

enum ImageExtension: String {
    case landscapeLarge
    case landscapeSmall
    case squareLarge
    case squareSmall

    var value: String {
        switch self {
            case .landscapeLarge:
                return "/landscape_xlarge.jpg"
            case .landscapeSmall:
                return "/portrait_small.jpg"
            case .squareLarge:
                return "/standard_xlarge.jpg"
            case .squareSmall:
                return "/standard_small.jpg"
        }
    }
}
