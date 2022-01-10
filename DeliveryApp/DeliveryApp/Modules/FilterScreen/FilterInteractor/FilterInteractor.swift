//
//  FilterInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation
import RxSwift

class FilterInteractor {
    var firebaseService: FirebaseServiceProtocol!
}

extension FilterInteractor: FilterInteractorInput {
    
    func getFilters() -> Single<[FiltersModel]>? {
        firebaseService.getFilters()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func setFilter(filter: FiltersModel) -> Single<String>? {
        firebaseService.setFilter(filter: filter)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func clearAllCategoriesFilters(isDeitery: Bool) -> Single<String>? {
        firebaseService.clearAllFilters(filterField: "isDietary", filterValue: isDeitery)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func getPriceFilters() -> Single<[PriceFilter]>? {
        firebaseService.getPriceFilters()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func setPriceFilter(filter: PriceFilter) -> Single<String>? {
        firebaseService.setPriceFilter(priceFilter: filter)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func clearAllPriceFilters() -> Single<String>? {
        firebaseService.clearAllPriceFilters()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
