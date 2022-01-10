//
//  DishDetailInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation
import RxSwift

protocol DishDetailInteractorInput {
    func obtainDish(dishId: Int, placeId: String) -> Single<DishesModel>?
    func setDishOrder(dish: DishesModel) -> Single<String>?
}
