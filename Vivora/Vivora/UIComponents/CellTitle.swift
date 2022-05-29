//
//  CellTitle.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import UIKit

final class CellTitle: UIView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    convenience init(withTitle title: String) {
        self.init()
        self.title = title
        setupViews()
    }

    let background: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.9
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.bangersRegular(size: 18)
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()

    /// A size suggestion.
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 400, height: 10)
    }
}

//MARK: - View setup
private extension CellTitle {
    func setupViews() {
        addSubview(background)
        background.addSubview(titleLabel)

        // Background

        background.anchor(topAnchor: topAnchor,
                          trailingAnchor: trailingAnchor,
                          bottomAnchor: bottomAnchor,
                          leadingAnchor: leadingAnchor)

        // Title label

        titleLabel.anchor(topAnchor: background.topAnchor,
                          trailingAnchor: nil, bottomAnchor: background.bottomAnchor,
                          leadingAnchor: background.leadingAnchor,
                          padding: .init(top: 2, left: 10,
                                         bottom: 3, right: .zero))
    }
}

