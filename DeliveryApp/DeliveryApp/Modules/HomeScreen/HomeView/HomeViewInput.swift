//
//  HomeViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation

protocol HomeViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupTableView(models: [TableViewCompatible])
}
