//
//  FilterViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation

protocol FilterViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupFilters(categories: [FiltersModel], dietary: [FiltersModel], priceFilters: [PriceFilter])
}
