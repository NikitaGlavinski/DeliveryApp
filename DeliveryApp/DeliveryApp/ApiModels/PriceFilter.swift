//
//  PriceFilter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/29/21.
//

import Foundation

struct PriceFilter: Codable {
    var id: Int
    var value: Int
    var isSelected: Bool
    
    init(id: Int, value: Int, isSelected: Bool) {
        self.id = id
        self.value = value
        self.isSelected = isSelected
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
        case isSelected = "isSelected"
    }
}
