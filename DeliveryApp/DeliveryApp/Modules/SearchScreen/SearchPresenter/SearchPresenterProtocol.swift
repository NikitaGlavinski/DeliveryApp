//
//  SearchPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func filterPlaces(with text: String)
    func showPlaceDetail(placeId: String)
}
