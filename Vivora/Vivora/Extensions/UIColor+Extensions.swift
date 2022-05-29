//
//  UIColor+Extensions.swift
//  Vivora
//
//  Created by Andoni Da silva on 26/5/22.
//

import UIKit

extension UIColor {

    convenience init?(named: String) {
        self.init(named: named, in: Bundle(for: HomeView.self), compatibleWith: nil)
    }

    static var vivoraMain: UIColor { get {return UIColor.init(named: "Main") ?? UIColor.black} }
    static var vivoraCell: UIColor { get {return UIColor.init(named: "HomeCell") ?? UIColor.black} }
    static var toastWarning: UIColor { get {return UIColor.init(named: "WarningToastYellow") ?? UIColor.black} }
    static var toastError: UIColor { get {return UIColor.init(named: "ErrorToastRed") ?? UIColor.black} }
    static var toastInfo: UIColor { get {return UIColor.init(named: "InfoToastGreen") ?? UIColor.black} }
    static var fontColor: UIColor { get {return UIColor.init(named: "FontColor") ?? UIColor.black} }
}
