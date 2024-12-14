//  SettingsView.swift
//  FoodHive
//  Created by Tushmi Sharma on 10/29/24.


import SwiftUI
import SwiftData

struct SettingsView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var currentUser: User?
    @State private var showingEditProfile = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        showingEditProfile = true
                    }) {
                        HStack {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.orange)
                            Text("Edit Profile")
                                .foregroundColor(.black)
                        }
                    }
                    .sheet(isPresented: $showingEditProfile) {
                        EditProfileView(currentUser: $currentUser)
                    }
                }
                
                Section {
                    Button(action: {
                        isUserLoggedIn = false
                        currentUser = nil
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward.circle.fill")
                                .foregroundColor(.red)
                            Text("Log Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
