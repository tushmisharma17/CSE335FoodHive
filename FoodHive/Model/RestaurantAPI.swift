//  RestaurantAPI.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import Foundation

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct Location: Decodable {
    let address1: String
    let city: String
}

struct Restaurant: Identifiable, Decodable {
    let id: String
    let name: String
    let rating: Double
    let location: Location
    let coordinates: Coordinates
    let image_url: String
}

class RestaurantAPI {
    static let shared = RestaurantAPI()
    private let apiKey = "IT9ydZ4EqBJZDS_6VW2qw0pbQkqwJjl1R5lPlZ6Ylou2m88wlGGsch6FPJoLKirOl5tTjxlY6wYzqCcTHTKiflccIEwqUfp_AfDcvvv1Aco4ccHdF5GqekP4bC9IZ3Yx" 

    func fetchRestaurants(location: String, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.yelp.com/v3/businesses/search?location=\(encodedLocation)&categories=restaurants"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received."])))
                return
            }

            do {
                let response = try JSONDecoder().decode(YelpResponse.self, from: data)
                completion(.success(response.businesses))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct YelpResponse: Decodable {
    let businesses: [Restaurant]
}
