//
//  OrderInterctorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

protocol OrderInterctorInput {
    func getUserOrders() -> Single<[DishesModel]>?
    func checkoutOrders() -> Single<String>?
}
