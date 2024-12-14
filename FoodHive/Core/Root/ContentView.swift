//  ContentView.swift
//  FoodHive
//  Created by Tushmi Sharma on 10/29/24.

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State var isUserLoggedIn: Bool
    @State var currentUser: User?

    init(isUserLoggedIn: Bool = false, currentUser: User? = nil) {
        self._isUserLoggedIn = State(initialValue: isUserLoggedIn)
        self._currentUser = State(initialValue: currentUser)
    }

    var body: some View {
        if isUserLoggedIn {
            TabView(selection: $selectedTab) {
                RestaurantListView()
                    .environmentObject(RestaurantSearchViewModel(currentUser: currentUser))
                    .tabItem {
                        Label("Restaurants", systemImage: "fork.knife")
                    }
                    .tag(0)

                NavigationView {
                    ProfileView(currentUser: $currentUser)
                }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(1)

                SettingsView(isUserLoggedIn: $isUserLoggedIn, currentUser: $currentUser)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(2)
            }
            .accentColor(.orange)
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn, currentUser: $currentUser)
        }
    }
}
