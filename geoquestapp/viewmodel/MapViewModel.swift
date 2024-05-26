//
//  MapViewModel.swift
//  geoquestapp
//
//  Created by robert theo on 21/05/24.
//

import SwiftUI
import MapKit
import WatchConnectivity

class ViewModel: NSObject, ObservableObject, WCSessionDelegate {
    @Published var selectedResult: MKMapItem?
    @Published var route: MKRoute?
    
    override init() {
        super.init()
        self.setupWatchConnectivity()
    }
    
    private func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    
    func getDirections() {
        self.route = nil
        
        guard let selectedResult = selectedResult else { return }
        
        let startingPoint = CLLocationCoordinate2D(
            latitude: -6.302046029681536,
            longitude: 106.65263729749853
        )
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startingPoint))
        request.destination = selectedResult
        
        Task {
            let directions = MKDirections(request: request)
            do {
                let response = try await directions.calculate()
                if let route = response.routes.first {
                    self.route = route
                    sendRouteToWatch(route: route)
                }
            } catch {
                print("Error calculating directions: \(error.localizedDescription)")
            }
        }
    }
    
    private func sendRouteToWatch(route: MKRoute) {
        guard WCSession.default.isReachable else { return }
        do {
            let routeData = try NSKeyedArchiver.archivedData(withRootObject: route, requiringSecureCoding: false)
            WCSession.default.sendMessage(["routeData": routeData], replyHandler: nil, errorHandler: { error in
                print("Error sending route data to watch: \(error.localizedDescription)")
            })
        } catch {
            print("Error archiving route data: \(error.localizedDescription)")
        }
    }
    
    // WCSessionDelegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
            return
        }
        print("WCSession activated with state: \(activationState.rawValue)")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
}
