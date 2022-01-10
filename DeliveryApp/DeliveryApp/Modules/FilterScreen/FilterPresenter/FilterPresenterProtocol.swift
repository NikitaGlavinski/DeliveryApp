//
//  FilterPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation

protocol FilterPresenterProtocol: AnyObject {
    func viewDidLoad()
    func updateFilter(filter: FiltersModel)
    func clearAllCategoriesFilters()
    func clearAllDietaryFilters()
    func updatePriceFilter(filter: PriceFilter)
    func clearAllPriceFilters()
}
