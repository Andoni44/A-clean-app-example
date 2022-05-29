//
//  VivoraSearchController.swift
//  Vivora
//
//  Created by Andoni Da silva on 27/5/22.
//

import UIKit

final class VivoraSearchController: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        configureSearchBarUI()
    }

    convenience init(searchResultsController: UIViewController? = nil,
                              title: String,
                              textColor: UIColor = UIColor.white) {
        self.init(searchResultsController: searchResultsController)
        configureSearchBarUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSearchBarUI(title: String = "home-search".localized,
                                      textColor: UIColor = UIColor.white) {
        searchBar.tintColor = textColor
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : textColor])
        }

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.vivoraCell
        }
       searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString(title, comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.tintColor])
    }
}
