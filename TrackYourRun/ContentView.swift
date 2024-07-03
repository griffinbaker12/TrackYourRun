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
            VStack {
                VStack {
                    Text("Stats")
                        .font(.title)
                    HStack {
                        Spacer()
                        VStack {
                            Text("Total Distance")
                                .font(.title3)
                            HStack {
                                Text("\(locationManager.totalDistance) Meters")
                                    .font(.headline)
                                Spacer()
                                Text("\(locationManager.totalDistance / 1000) Kilometers")
                                    .font(.headline)
                            }
                        }
                        Spacer()
                        VStack {
                            Text("Is tracking?")
                                .font(.title3)
                            Text("\(locationManager.isTracking)")
                                .font(.title3)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            Map {
                MapPolyline(coordinates: locationManager.locations.map { $0.coordinate })
                    .stroke(Color.blue, lineWidth: 4)
            }
            .frame(height: 300)
            .onChange(of: locationManager.totalDistance) {
                print("The distance you have travelled thus far: \(locationManager.totalDistance)")
            }
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
