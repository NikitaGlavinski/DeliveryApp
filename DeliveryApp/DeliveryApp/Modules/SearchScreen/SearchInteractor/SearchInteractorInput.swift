//
//  SearchInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import Foundation
import RxSwift

protocol SearchInteractorInput {
    func getPlaces() -> Single<[PlaceModel]>?
}
