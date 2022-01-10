//
//  DishesModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import Foundation

struct DishesModel: Codable {
    var id: Int
    var name: String
    var description: String
    var foodType: [String]
    var image: String
    var price: Float
    var priceType: Int
    var choices: [String]
    
    init(
        id: Int,
        name: String,
        description: String,
        foodType: [String],
        image: String,
        price: Float,
        priceType: Int,
        choices: [String]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.foodType = foodType
        self.image = image
        self.price = price
        self.priceType = priceType
        self.choices = choices
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case foodType = "foodType"
        case image = "image"
        case price = "price"
        case priceType = "priceType"
        case choices = "choices"
    }
}
