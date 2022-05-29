//
//  HomeCell.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import UIKit
import SDWebImage

final class HomeCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Animation

    private let shrinkScale: CGFloat = 0.95
    private let shrinkDuration: TimeInterval = 0.25

    // MARK: On tap action
    
    var onTapAction: (() -> Void)?

    // MARK: Outlets

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.placeholder
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let label: CellTitle = {
        let title = CellTitle(withTitle: "")
        return title
    }()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        beginShrinkScale()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endShrinkScale()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        endShrinkScale(succes: false)
    }

    // MARK: Configuration

    func configureWith(character: Character, onTapAction: @escaping () -> Void) {
        let url = URL(string: character.image)
        backgroundImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage.placeholder)
        label.title = character.name
        self.onTapAction = onTapAction
    }
}

// MARK: - Inner methods

private extension HomeCell {
    func configureBackgroundColor(isSelected: Bool = false) {
        label.background.backgroundColor = isSelected ? UIColor.tintColor : .lightGray
        label.titleLabel.textColor = isSelected ? .fontColor : .white
        label.titleLabel.font = isSelected ? UIFont.bangersRegular(size: 25) : UIFont.bangersRegular(size: 18)
    }
}

// MARK: - Shrinking

private extension HomeCell {
    func beginShrinkScale() {
        UIView.animate(withDuration: shrinkDuration) {
            self.configureBackgroundColor(isSelected: true)
            self.transform = CGAffineTransform.identity
                .scaledBy(x: self.shrinkScale, y: self.shrinkScale)
            self.layoutIfNeeded()
        }
    }

    func endShrinkScale(succes: Bool = true) {
        UIView.animate(withDuration: shrinkDuration, animations: {
            self.configureBackgroundColor(isSelected: false)
            self.transform = .identity
            self.layoutIfNeeded()
        }, completion: { [onTapAction] _ in
            if succes {
                guard let action = onTapAction else { return }
                action()
            }
        })
    }
}

//MARK: - Constraints

private extension HomeCell {
    func setupViews() {
        let height: CGFloat = (frame.width * 65) / 100
        let padding: CGFloat = 10
        backgroundColor = UIColor.clear
        let contentView = UIView()
        addSubview(contentView)
        [backgroundImageView, label].forEach {
            contentView.addSubview($0)
        }
        contentView.roundCorners(corners: [.allCorners], radius: 5)

        // Background

        backgroundImageView.anchor(topAnchor: contentView.topAnchor,
                                   trailingAnchor: contentView.trailingAnchor,
                                   bottomAnchor: contentView.bottomAnchor,
                                   leadingAnchor: contentView.leadingAnchor,
                                   size: .init(width: .zero, height: height))

        // Label

        label.anchor(topAnchor: nil,
                     trailingAnchor: contentView.trailingAnchor,
                     bottomAnchor: contentView.bottomAnchor,
                     leadingAnchor: contentView.leadingAnchor)

        // Container

        contentView.anchor(topAnchor: topAnchor,
                           trailingAnchor: trailingAnchor,
                           bottomAnchor: bottomAnchor,
                           leadingAnchor: leadingAnchor,
                           padding: .init(top: padding, left: padding,
                                          bottom: padding, right: padding))
    }
}

