//  User.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import SwiftData

@Model
class User {
    @Attribute(.unique) var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var defaultAddress: String

    init(email: String, password: String, firstName: String, lastName: String, phoneNumber: String, defaultAddress: String = "") {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.defaultAddress = defaultAddress
    }
}
