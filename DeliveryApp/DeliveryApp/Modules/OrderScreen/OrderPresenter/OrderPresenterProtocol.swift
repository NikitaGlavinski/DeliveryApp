//
//  OrderPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

protocol OrderPresenterProtocol: AnyObject {
    func viewWillAppear()
    func checkoutOrder()
}
