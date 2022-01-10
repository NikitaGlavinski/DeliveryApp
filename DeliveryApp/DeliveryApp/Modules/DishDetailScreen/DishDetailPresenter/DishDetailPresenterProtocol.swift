//
//  DishDetailPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation

protocol DishDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func selectChoice(with name: String)
    func closeView()
    func setDishOrder()
}
