//
//  OrderViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

protocol OrderViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupTableView(cellModels: [TableViewCompatible])
}
