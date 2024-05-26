//
//  SampleMap.swift
//  geoquest Watch App
//
//  Created by robert theo on 22/05/24.
//

import SwiftUI

struct SampleMap: View {
    @StateObject private var locationManager = LocationManager()
    @Binding var points: Int
    @State private var showAlert = false
    @State private var showQuiz = false

    let pointA = CLLocation(latitude: -6.233180068802609, longitude: 106.62280899459725)
    let pointB = CLLocation(latitude: -6.233162821458921, longitude: 106.62287272525296)

    var body: some View {
        VStack {
            ZStack {
                if let heading = locationManager.heading {
                    let bearing = calculateBearing(from: pointA, to: pointB)
                    let direction = (bearing - heading.magneticHeading + 360).truncatingRemainder(dividingBy: 360)

                    ArrowView(direction: direction)
                        .padding()
                        .rotationEffect(.degrees(direction))
                }
            }

            NavigationLink(destination: QuizView(isPresented: $showQuiz, points: $points), isActive: $showQuiz) {
                EmptyView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Arrived"),
                message: Text("You have arrived at your destination"),
                dismissButton: .default(Text("Play Quiz")) {
                    showQuiz = true
                }
            )
        }
        .onAppear {
            locationManager.checkArrival(at: pointB, currentLocation: pointB)
        }
        .onReceive(locationManager.$heading) { _ in
            if locationManager.isAtDestination {
                showAlert = true
            }
        }
    }
}

#Preview {
    SampleMap(points: .constant(0))
}

