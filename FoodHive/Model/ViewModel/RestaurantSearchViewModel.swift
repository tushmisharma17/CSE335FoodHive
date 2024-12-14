//  RestaurantSearchViewModel.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.


import SwiftUI

class RestaurantSearchViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentUser: User?

    init(currentUser: User?) {
        self.currentUser = currentUser
    }

    func searchRestaurants(location: String) {
        isLoading = true
        errorMessage = nil
        restaurants = []

        RestaurantAPI.shared.fetchRestaurants(location: location) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedRestaurants):
                    self?.restaurants = fetchedRestaurants
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
