//
//  LocationManager.swift
//  AMplify
//
//  Created by William on 08/05/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    let appleDevAcademyLocation = CLLocation(latitude: -6.301976713655676, longitude: 106.65306645086578)
    @Published var distanceFromAcademy : Double = Double.infinity
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var formattedDistanceFromAcademy : String {
        if distanceFromAcademy >= 1 {
                return String(format: "%.0f", distanceFromAcademy)
            } else {
                return String(format: "%.2f", distanceFromAcademy)
            }
    }
    
    var clockInEnabled : Bool {
        return distanceFromAcademy <= 0.15
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }
    
    func requestPermission() {
        manager.requestAlwaysAuthorization()
    }
    
    func startListenForLocation() {
        manager.startUpdatingLocation()
    }
    
    func startListenForSignificantLocationChanges() {
        manager.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
        print("Stopped updating location")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            self.authorizationStatus = manager.authorizationStatus
            
            self.distanceFromAcademy = location.distance(from: self.appleDevAcademyLocation)/1000
            
            print("Updating Location : \(self.distanceFromAcademy)")
        }
    }
   
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        DispatchQueue.main.async {
            self.authorizationStatus = status
            print("Authorization status changed to: \(status.rawValue)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
