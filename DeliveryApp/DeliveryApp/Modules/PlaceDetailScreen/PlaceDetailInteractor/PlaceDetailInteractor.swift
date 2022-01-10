//
//  PlaceDetailInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

class PlaceDetailInteractor {
    var firebaseService: FirebaseServiceProtocol!
}

extension PlaceDetailInteractor: PlaceDetailInteractorInput {
    
    func getPlace(placeId: String) -> Single<PlaceModel>? {
        firebaseService.getPlace(placeId: placeId)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func getDishes(placeId: String) -> Single<[DishesModel]>? {
        firebaseService.getDishes(placeId: placeId)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
