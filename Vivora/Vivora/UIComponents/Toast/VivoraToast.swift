//
//  Alert.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

public final class VivoraToast: UIView {

    // MARK: - Struct Parameters

    public struct Parameters: Equatable, Hashable {
        public enum `Type` {
            case alert
            case info
            case error
        }

        // MARK: Variables

        public let title: String?
        public let description: String?
        public let type: Type
        let image: UIImage?

        // MARK: Init

        public init(title: String? = nil, description: String,
                    type: Type? = .alert, image: UIImage? = nil) {
            self.title = title
            self.description = description
            self.type = type ?? .alert
            self.image = image
        }

        // MARK: Methods

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(type)
        }

        // MARK: operator overload

        public static func == (lhs: Parameters, rhs: Parameters) -> Bool {
            return lhs.title == rhs.title && lhs.description == rhs.description && lhs.type == rhs.type && lhs.image == rhs.image
        }

    }

    // MARK: Static Variables

    private static let descriptionLineSpacing: CGFloat = 1.29
    private static let infoFontSize: CGFloat = 14.0
    private static let constraintTitle: CGFloat = 16
    private static let constraintWithoutTitle: CGFloat = 29
    private static let spacingTitle: CGFloat = 0
    private static let spacingWithoutTitle: CGFloat = 10

    // MARK: Variables

    public private(set) var parameters: Parameters?
    private var completionHandler: ((_ tapped: Bool) -> Void)?

    // MARK: Outlets

    @IBOutlet private weak var infoContentView: UIView!
    @IBOutlet private weak var infoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!

    // MARK: Life-Cycle

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: Public Methods

    public func set(_ parameters: Parameters, completion: ((_ tapped: Bool) -> Void)? = nil) {

        self.parameters = parameters
        completionHandler = completion

        if let title = parameters.title, !title.isEmpty {
            bottomConstraint.constant = VivoraToast.constraintTitle
            stackView.spacing = VivoraToast.spacingTitle
            titleLabel.text = title
            titleLabel.font = UIFont.barlowRegular(size: 12)

        } else {
            titleLabel.text = ""
            stackView.spacing = VivoraToast.spacingWithoutTitle
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = VivoraToast.descriptionLineSpacing

        let textString = NSMutableAttributedString(
            string: parameters.description ?? "",
            attributes: [
                .font: UIFont.barlowRegular(size: 12),
                .paragraphStyle: paragraphStyle
            ]
        )

        descriptionLabel.attributedText = textString

        if titleLabel.text?.isEmpty ?? false {
            let numLines = getNumLinesSubtitle(subtitleString: descriptionLabel.text ?? "")
            if numLines > 1 {
                bottomConstraint.constant = VivoraToast.constraintTitle
            } else {
                bottomConstraint.constant = VivoraToast.constraintWithoutTitle
            }
        } else {
            bottomConstraint.constant = VivoraToast.constraintTitle
        }

        switch parameters.type {
            case .alert:
                infoContentView.backgroundColor = .toastWarning
                infoImageView.image = parameters.image ?? UIImage(systemName: "exclamationmark.triangle")
            case .error:
                infoContentView.backgroundColor = .toastError
                infoImageView.image = parameters.image ?? UIImage(systemName: "exclamationmark.octagon")
            case .info:
                infoContentView.backgroundColor = .toastInfo
                infoImageView.image = parameters.image ?? UIImage(systemName: "info.circle")
        }

    }

    @objc
    public func tapped() {
        completionHandler?(true)
    }

    @objc
    public func hidden() {
        completionHandler?(false)
    }

    // MARK: Private methods

    private func getNumLinesSubtitle(subtitleString: String) -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let font = descriptionLabel.font ?? .barlowRegular(size: 12)
        let textHeight = subtitleString.boundingRect(with: maxSize,
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: [.font: font],
                                                     context: nil).height
        let lineHeight = descriptionLabel.font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }

    private func setupUI() {
        backgroundColor = .white

        // Setup title label
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1

        // Setup description label
        descriptionLabel.font = .barlowRegular(size: 12)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0

        // Setup Custom Layer
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0.0, height: 10)

        // Setup Close Button
        closeButton.setImage(.remove, for: .normal)
        closeButton.addTarget(self, action: #selector(VivoraToast.hidden), for: .touchUpInside)

        // Setup Swipe Recognizer
        let swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(VivoraToast.hidden))
        swipeGR.direction = .up
        addGestureRecognizer(swipeGR)

        // Setup Tap Recognizer
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(VivoraToast.tapped))
        tapGR.numberOfTapsRequired = 1
        addGestureRecognizer(tapGR)

    }

    // MARK: Static Methods

    public static func loadNib(owner: Any?) -> VivoraToast {
        guard
            let toast = (Bundle.init(for: self).loadNibNamed("VivoraToast",
                                                             owner: owner,
                                                             options: nil)?[0] as? VivoraToast)
        else { return VivoraToast() }

        return toast
    }

}
