//
//  RegisterViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation

protocol RegisterViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
}
