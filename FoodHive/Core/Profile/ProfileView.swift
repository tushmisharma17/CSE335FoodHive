//  ProfileView.swift
//  FoodHive
//  Created by Tushmi Sharma on 10/29/24.

import SwiftUI

struct ProfileView: View {
    @Binding var currentUser: User?

    var body: some View {
        VStack(spacing: 20) {
            if let user = currentUser {
                VStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 120, height: 120)
                        .overlay(
                            Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        )
                        .shadow(radius: 5)
                    
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(user.email)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.orange)
                            Text(user.email)
                                .font(.headline)
                        }
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.orange)
                            Text(user.phoneNumber)
                                .font(.headline)
                        }
                        if !user.defaultAddress.isEmpty {
                            HStack {
                                Image(systemName: "house.fill")
                                    .foregroundColor(.orange)
                                Text(user.defaultAddress)
                                    .font(.headline)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            } else {
                Text("No user data available.")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Profile")
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.orange.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
