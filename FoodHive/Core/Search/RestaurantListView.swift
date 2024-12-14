//  RestaurantListView.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import SwiftUI

struct RestaurantListView: View {
    @State private var location = ""
    @EnvironmentObject var viewModel: RestaurantSearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    TextField("Enter city or zip code", text: $location)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.searchRestaurants(location: location)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    List(viewModel.restaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            HStack(alignment: .top) {
                                AsyncImage(url: URL(string: restaurant.image_url)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(restaurant.name)
                                        .font(.headline)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                        Text("\(restaurant.rating, specifier: "%.1f")")
                                            .font(.subheadline)
                                    }
                                    Text(restaurant.location.address1)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 5)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Find Food Places")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: ProfileView(currentUser: $viewModel.currentUser)) {
                    if let user = viewModel.currentUser {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
                                    .foregroundColor(.white)
                            )
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.orange)
                    }
                }
            )
        }
    }
}
