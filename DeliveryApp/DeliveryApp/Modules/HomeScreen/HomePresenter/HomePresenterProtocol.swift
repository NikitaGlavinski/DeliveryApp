//
//  HomePresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func showFilters()
    func showDetailPlace(placeId: String)
}
