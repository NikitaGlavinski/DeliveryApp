//
//  SearchInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import Foundation
import RxSwift

class SearchInteractor {
    var firebaseService: FirebaseServiceProtocol!
}

extension SearchInteractor: SearchInteractorInput {
    
    func getPlaces() -> Single<[PlaceModel]>? {
        firebaseService.getPlaces()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
