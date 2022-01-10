//
//  PlaceDetailViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

protocol PlaceDetailViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupTableView(models: [TableViewCompatible])
    func updateTableView(models: [TableViewCompatible], fromIndex: Int, toIndex: Int)
}
