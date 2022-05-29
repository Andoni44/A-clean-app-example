//
//  UIImage+Extensions.swift
//  Vivora
//
//  Created by Andoni Da silva on 26/5/22.
//

import UIKit

extension UIImage {
    public class var placeholder: UIImage { get { UIImage.named("placeholder").withRenderingMode(.alwaysOriginal) } }

    private static func named(_ imageName: String) -> UIImage {
        guard let image = self.init(named: imageName, in: Bundle(for: HomeView.self), compatibleWith: nil) else {
            fatalError("Missing image resource: \(imageName)")
        }
        return image
    }
}
