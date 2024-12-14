//  RestaurantDetailView.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import SwiftUI
import MapKit

struct RestaurantDetailView: View {
    let restaurant: Restaurant

    
    @State private var showFullScreenMap = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    AsyncImage(url: URL(string: restaurant.image_url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 250)
                    .clipped()
                    
                    Text(restaurant.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("\(restaurant.rating, specifier: "%.1f")")
                            .font(.title2)
                    }
                    .padding(.horizontal)

                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.orange)
                        Text(restaurant.location.address1)
                            .font(.title3)
                    }
                    .padding(.horizontal)

                    // Map View
                    MapView(coordinate: CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude))
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding()
                        .onTapGesture {
                            showFullScreenMap.toggle()
                        }
                }
            }
            .navigationTitle(restaurant.name)
            .sheet(isPresented: $showFullScreenMap) {
                
                FullScreenMapView(coordinate: CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude))
            }
        }
    }
}


struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.isZoomEnabled = true
        map.isScrollEnabled = true

        
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        map.setRegion(region, animated: false)

        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}


struct FullScreenMapView: View {
    let coordinate: CLLocationCoordinate2D
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            MapView(coordinate: coordinate)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Map View", displayMode: .inline)
                .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
