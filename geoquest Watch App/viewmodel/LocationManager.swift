//
//  LocationManager.swift
//  geoquest Watch App
//
//  Created by robert theo on 22/05/24.
//

import SwiftUI
import CoreLocation

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//    @Published var heading: CLHeading?
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingHeading()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        heading = newHeading
//    }
//}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var heading: CLHeading?
    @Published var isAtDestination = false // Add a state variable to track arrival

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            checkArrival(at: CLLocation(latitude: -6.233170645321756, longitude: 106.62287110613421), currentLocation: location)
        }
    }

    func checkArrival(at destination: CLLocation, currentLocation: CLLocation) {
        let distance = currentLocation.distance(from: destination)
        if distance < 10 {
            isAtDestination = true
        }
    }
}


func calculateBearing(from location: CLLocation, to destination: CLLocation) -> Double {
    let lat1 = location.coordinate.latitude.toRadians()
    let lon1 = location.coordinate.longitude.toRadians()
    let lat2 = destination.coordinate.latitude.toRadians()
    let lon2 = destination.coordinate.longitude.toRadians()

    let dLon = lon2 - lon1
    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
    let bearing = atan2(y, x).toDegrees()
    
    return (bearing + 360).truncatingRemainder(dividingBy: 360)
}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180
    }
    
    func toDegrees() -> Double {
        return self * 180 / .pi
    }
}
