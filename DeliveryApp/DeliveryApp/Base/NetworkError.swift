//
//  NetworkError.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation

enum NetworkError: String, Error {
    case authError = "Authorization error"
    case noData = "No data"
    case uncategorized = "UNCATEGORIZED"
}
