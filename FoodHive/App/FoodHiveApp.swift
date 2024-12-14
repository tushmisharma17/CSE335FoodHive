//  FoodHiveApp.swift
//  FoodHive
//  Created by Tushmi Sharma on 10/29/24.

import SwiftUI
import SwiftData

@main
struct FoodHiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self, RestaurantEntity.self])
        }
    }
}
