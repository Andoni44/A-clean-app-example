//
//  UIView+Corner.swift
//  Vivora
//
//  Created by Andoni Da silva on 26/5/22.
//

import UIKit

extension UIView {
    public func roundCorners (corners: [UIRectCorner], radius: CGFloat) {
        var myMaskedCorners: CACornerMask = CACornerMask()
        corners.forEach { (corner) in
            switch corner {
                case .topLeft:
                    myMaskedCorners.insert(.layerMinXMinYCorner)
                case .topRight:
                    myMaskedCorners.insert(.layerMaxXMinYCorner)
                case .bottomLeft:
                    myMaskedCorners.insert(.layerMinXMaxYCorner)
                case .bottomRight:
                    myMaskedCorners.insert(.layerMaxXMaxYCorner)
                case .allCorners:
                    myMaskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMinXMaxYCorner,
                                       .layerMaxXMaxYCorner]
                default:break
            }
        }
        self.clipsToBounds =  true
        layer.cornerRadius = radius
        layer.maskedCorners = myMaskedCorners
    }
}
