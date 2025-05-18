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
    
    static let appleDevAcademyLocation = CLLocation(latitude: -6.301976713655676, longitude: 106.65306645086578)
    @Published var distanceFromAcademy : Double = 200
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var formattedDistanceFromAcademy : String {
        return IOHelper.shared.formattedDistance(distance: distanceFromAcademy)
    }
    
    var clockInEnabled : Bool {
        return distanceFromAcademy <= 0.15
    }
    
    var significantLocation : Int = Int.max
    
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
            
            self.distanceFromAcademy = location.distance(from: LocationManager.appleDevAcademyLocation)/1000
            if self.distanceFromAcademy > 1 && self.significantLocation > Int(self.distanceFromAcademy) {
                // update live activity once every 1KM
                LiveActivityManager.shared.updateActivity(distance: self.distanceFromAcademy)
                self.significantLocation = Int(self.distanceFromAcademy)
                print("test \(self.significantLocation)")
            }
            else if self.distanceFromAcademy < 1 {
                // once below 1 KM , update every time location changes
                LiveActivityManager.shared.updateActivity(distance: self.distanceFromAcademy)
            }
            
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
