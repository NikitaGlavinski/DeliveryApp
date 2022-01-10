//
//  PlaceDetailInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import RxSwift
import Foundation

protocol PlaceDetailInteractorInput {
    func getPlace(placeId: String) -> Single<PlaceModel>?
    func getDishes(placeId: String) -> Single<[DishesModel]>?
}
