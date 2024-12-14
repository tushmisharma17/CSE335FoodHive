//  RestaurantEntity.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import SwiftData

@Model
class RestaurantEntity {
    @Attribute(.unique) var id: String 
    var name: String
    var rating: Double
    var address: String

    init(id: String, name: String, rating: Double, address: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.address = address
    }
}
