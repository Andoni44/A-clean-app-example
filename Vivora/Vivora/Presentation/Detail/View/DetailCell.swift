//
//  DetailCell.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit
import SDWebImage

final class DetailCell: UICollectionViewCell {
    @IBOutlet private(set) weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    func configureWith(imageURL: String) {
        let url = URL(string: imageURL)
        image.sd_setImage(with: url,
                          placeholderImage: UIImage.placeholder)
    }
}
