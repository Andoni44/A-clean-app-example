//
//  UIFont+Extensions.swift
//  Vivora
//
//  Created by Andoni Da silva on 26/5/22.
//

import UIKit

extension UIFont {
    static func antonRegular(size: CGFloat) -> UIFont {
        let fontName = "Anton-Regular"
        return UIFont(name: fontName, size: size) ?? systemFont(ofSize: size)
    }
    static func barlowRegular(size: CGFloat) -> UIFont {
        let fontName = "BarlowCondensed-Regular"
        return UIFont(name: fontName, size: size) ?? systemFont(ofSize: size)
    }
    static func bangersRegular(size: CGFloat) -> UIFont {
        let fontName = "Bangers-Regular"
        return UIFont(name: fontName, size: size) ?? systemFont(ofSize: size)
    }

    private static func registerFont(withName name: String, fileExtension: String) {
        let frameworkBundle = Bundle(for: HomeView.self)
        guard
            let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension),
            let fontData = NSData(contentsOfFile: pathForResourceString),
            let dataProvider = CGDataProvider(data: fontData),
            let fontRef = CGFont(dataProvider)
        else { return }

        var errorRef: Unmanaged<CFError>? = nil

        CTFontManagerRegisterGraphicsFont(fontRef, &errorRef)
    }

    public static func loadFonts(fonts: [(fontName: String, fontExtension: String)]) {
        fonts.forEach {
            registerFont(withName: $0.fontName, fileExtension: $0.fontExtension)
        }
    }
}
