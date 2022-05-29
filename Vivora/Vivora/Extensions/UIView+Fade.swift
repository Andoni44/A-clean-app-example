//
//  UIView+Fade.swift
//  Vivora
//
//  Created by Andoni Da silva on 26/5/22.
//

import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }

    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
