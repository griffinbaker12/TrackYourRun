//
//  ContentView.swift
//  TrackYourRun
//
//  Created by Griffin Baker on 7/2/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Map {
                MapPolyline(coordinates: locationManager.locations.map { $0.coordinate })
                    .stroke(Color.blue, lineWidth: 4)
                if let currentLocation = locationManager.currentLocation {
                    Marker("You", coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
                }
            }
            .onChange(of: locationManager.totalDistance) {
                print("The distance you have travelled thus far: \(locationManager.totalDistance)")
            }
            VStack {
                VStack(spacing: 16) {
                    HStack {
                        Circle()
                            .fill(locationManager.isTracking ? .green : .red)
                            .frame(width: 16, height: 16)
                        Text("Tracking: \(locationManager.isTracking)")
                            .foregroundStyle(.black)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.white)
                    .cornerRadius(8)
                    VStack(spacing: 4) {
                        Text("Total Distance")
                            .font(.title3)
                        if locationManager.isTracking {
                            HStack {
                                Text("\(locationManager.totalDistance) Meters")
                                    .font(.headline)
                                Spacer()
                                Text("\(locationManager.totalDistance / 1000) Kilometers")
                                    .font(.headline)
                            }
                        } else {
                            Text("No distance to report.")
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.black)
                    .cornerRadius(8)
                    .foregroundStyle(.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                Spacer()
            }
            .padding(.top, 8)
            VStack {
                Spacer()
                HStack {
                    Button("Stop") {
                        locationManager.stopTracking()
                    }
                    Button("Start") {
                        locationManager.startTracking()
                    }
                }
            }
        }
    }
    
    private func formatDistance(_ distance: Double) -> String {
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        let kilometers = meters.converted(to: .kilometers)
        return String(format: "%.2f km", kilometers.value)
    }
}
