//
//  DishDetailViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation

protocol DishDetailViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupTableView(cellModels: [TableViewCompatible], imageURL: String)
}
