//
//  DishDetailInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation
import RxSwift

class DishDetailInteractor {
    var firebaseService: FirebaseServiceProtocol!
    var secureStorage: SecureStorageServiceProtocol!
}

extension DishDetailInteractor: DishDetailInteractorInput {
    
    func obtainDish(dishId: Int, placeId: String) -> Single<DishesModel>? {
        firebaseService.getDish(dishId: dishId, placeId: placeId)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func setDishOrder(dish: DishesModel) -> Single<String>? {
        let userToken = secureStorage.obtainToken() ?? ""
        return firebaseService.setUserOrder(dish: dish, userToken: userToken)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
