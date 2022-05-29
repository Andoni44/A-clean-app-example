//
//  DetailHeader.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

final class HeaderDetailView: UIView {
    let header: UIView = {
        let stack = UIView()
        return stack
    }()

    let nameLabel: UILabel = {
        let component = UILabel()
        component.numberOfLines = 1
        component.font = UIFont(name: "Bangers-Regular", size: 20)
        component.textColor = .fontColor
        component.lineBreakMode = NSLineBreakMode.byWordWrapping
        component.sizeToFit()
        return component
    }()

    let nameBackground: UIView = {
        let component = UIView()
        component.backgroundColor = UIColor.tintColor
        return component
    }()

    let imageView: UIImageView = {
        let component = UIImageView()
        component.backgroundColor = .black
        component.contentMode = .scaleToFill
        component.image = #imageLiteral(resourceName: "placeholder")
        return component
    }()

    init() {
        super.init(frame: CGRect())
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Anchors

private extension HeaderDetailView {
    func setupViews() {
        addSubview(header)
        header.addSubview(imageView)
        header.addSubview(nameBackground)
        nameBackground.addSubview(nameLabel)

        // Header
        header.anchor(topAnchor: topAnchor,
                      trailingAnchor: trailingAnchor,
                      bottomAnchor: bottomAnchor,
                      leadingAnchor: leadingAnchor,
                      padding: .init(top: .zero, left: 10,
                                     bottom: .zero, right: 10))

        // ImageView
        imageView.anchor(topAnchor: header.topAnchor,
                         trailingAnchor: header.trailingAnchor,
                         bottomAnchor: header.bottomAnchor,
                         leadingAnchor: header.leadingAnchor)

        // NameLabel
        nameLabel.anchor(topAnchor: nameBackground.topAnchor,
                         trailingAnchor: nameBackground.trailingAnchor,
                         bottomAnchor: nameBackground.bottomAnchor,
                         leadingAnchor: nameBackground.leadingAnchor,
                         padding: .init(top: 2, left: 2, bottom: 3, right: 4))

        // NameBackground
        nameBackground.anchor(topAnchor: nil,
                              trailingAnchor: header.trailingAnchor,
                              bottomAnchor: header.bottomAnchor,
                              leadingAnchor: nil,
                              padding: .init(top: .zero, left: .zero, bottom: 10, right: 15))
    }
}
