//
//  PlaceModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import Foundation

struct PlaceModel: Codable {
    var id: String
    var name: String
    var location: String
    var price: Int
    var rating: Float
    var deliveryType: String
    var deliveryTime: Int
    var categories: [String]
    var images: [String]
    var foodType: [String]
    
    init(
        id: String,
        name: String,
        location: String,
        price: Int,
        rating: Float,
        deliveryType: String,
        deliveryTime: Int,
        categories: [String],
        images: [String],
        foodType: [String]
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.price = price
        self.rating = rating
        self.deliveryType = deliveryType
        self.deliveryTime = deliveryTime
        self.categories = categories
        self.images = images
        self.foodType = foodType
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case location = "location"
        case price = "price"
        case rating = "rating"
        case deliveryType = "deliveryType"
        case deliveryTime = "deliveryTime"
        case categories = "categories"
        case images = "images"
        case foodType = "foodType"
    }
}
