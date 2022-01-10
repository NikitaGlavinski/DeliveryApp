//
//  OrderInterctor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

class OrderInterctor {
    var firebaseService: FirebaseServiceProtocol!
    var secureStorage: SecureStorageServiceProtocol!
}
extension OrderInterctor: OrderInterctorInput {
    
    func getUserOrders() -> Single<[DishesModel]>? {
        let userToken = secureStorage.obtainToken() ?? ""
        return firebaseService.getUserOrders(userToken: userToken)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func checkoutOrders() -> Single<String>? {
        let userToken = secureStorage.obtainToken() ?? ""
        return firebaseService.deleteOrders(userToken: userToken)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
