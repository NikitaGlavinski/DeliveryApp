//
//  PlaceDetailPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

protocol PlaceDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func filterDishes(by category: String)
    func showDishDetail(dishId: Int)
}
