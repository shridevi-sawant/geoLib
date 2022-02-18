//
//  ThirdApproach.swift
//  geoLib
//
//  Created by SHRIDEVI SAWANT on 17/02/22.
//


import Foundation
import CoreLocation

class LocationReporter: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationReporter()
    var currentLoc : CLLocation?
    
    
    
    func startUpdating(locationManager: CLLocationManager) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdating(locationManager: CLLocationManager) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLoc = location
            print("latitude: ", location.coordinate.latitude)
            print("longitude: ", location.coordinate.longitude)
        }
}
}

class LocationDetectionClient {
    
    private let locationManager = CLLocationManager()
    
    func start() {
        LocationReporter.sharedInstance.startUpdating(locationManager: locationManager)
    }
    
    func stop() {
        LocationReporter.sharedInstance.stopUpdating(locationManager: locationManager)
    }
    
    func getLocation() -> CLLocation? {
        print("Returned loc: \(LocationReporter.sharedInstance.currentLoc?.coordinate.latitude ?? 0.0)")
        return LocationReporter.sharedInstance.currentLoc
    }
    
}

let locationDetectionClient = LocationDetectionClient()

public func startLocationDetection() {
    locationDetectionClient.start()
}

public func stopLocationDetection() {
    locationDetectionClient.stop()
}

public func getLocation() -> CLLocation? {
    print("Return from public getLoc")
    return locationDetectionClient.getLocation()
}
