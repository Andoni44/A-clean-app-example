//
//  BaseProtocols.swift
//  Vivora
//
//  Created by Andoni Da silva on 29/5/22.
//

import Foundation

protocol BasePresenterToViewProtocol: AnyObject {
    func startAnimation()
    func stopAnimation()
    func display(error: String)
}

