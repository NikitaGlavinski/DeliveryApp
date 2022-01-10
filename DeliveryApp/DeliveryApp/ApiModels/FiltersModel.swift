//
//  FiltersModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation

struct FiltersModel: Codable {
    var id: Int
    var name: String
    var isSelected: Bool
    var isDietary: Bool
    
    init(id: Int, name: String, isSelected: Bool, isDietary: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
        self.isDietary = isDietary
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isSelected = "isSelected"
        case isDietary = "isDietary"
    }
}
