//
//  BaseVivoraViewController.swift
//  Vivora
//
//  Created by Andoni Da silva on 28/5/22.
//

import UIKit

public class BaseVivoraViewController: UIViewController {
    public func showToast(title: String, message: String, duration: VivoraToastManager.Duration) {
        let params = VivoraToast.Parameters(title: title, description: message, type: .alert)
        displayToast(params)
    }


    public func showErrorToast(title: String, message: String, duration: VivoraToastManager.Duration) {
        let params = VivoraToast.Parameters(title: title, description: message, type: .error)
        displayToast(params)
    }

    public func hideToast() {
        if let navigationController = self.navigationController {
            navigationController.view.hideToast()
        } else {
            self.view.hideToast()
        }
    }

    private func displayToast(_ params: VivoraToast.Parameters, completion: ((_ didTap: Bool) -> Void)? = nil) {
        if let navigationController = self.navigationController {
            navigationController.view.createToast(params, completion: completion)

        } else {
            self.view.createToast(params, completion: completion)

        }
    }
}
