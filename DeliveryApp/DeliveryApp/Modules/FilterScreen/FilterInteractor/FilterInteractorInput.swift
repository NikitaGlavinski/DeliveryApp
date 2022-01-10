//
//  FilterInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation
import RxSwift

protocol FilterInteractorInput {
    func getFilters() -> Single<[FiltersModel]>?
    func setFilter(filter: FiltersModel) -> Single<String>?
    func clearAllCategoriesFilters(isDeitery: Bool) -> Single<String>?
    func getPriceFilters() -> Single<[PriceFilter]>?
    func setPriceFilter(filter: PriceFilter) -> Single<String>?
    func clearAllPriceFilters() -> Single<String>?
}
