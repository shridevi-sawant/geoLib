//
//  LocationWrapper.swift
//  geoLib
//
//  Created by SHRIDEVI SAWANT on 18/02/22.
//

import Foundation
import CoreLocation

public class LocationWrapper {
    
    let utility = LocationUtility()
    
    public init(){}
    
    public func startTracking() {
        utility.startTracking()
    }
    
    public func stopTracking(){
        utility.stopTracking()
    }
    
    public func getCurrentLocation() -> CLLocation? {
        return utility.currentLocation
    }
    
    public func getCurrentAddress(completion: @escaping (String) -> Void ){
        // geocoding
        
        let gc = CLGeocoder()
        if let loc = utility.currentLocation {
            gc.reverseGeocodeLocation(loc) { (placeResult, err) in
                
                if let addr = placeResult?.first {
                    let streetAddr = "\(addr.subLocality ?? ""), \(addr.locality ?? ""), \(addr.country ?? ""), \(addr.administrativeArea ?? "")"
                    
                    print("Address: \(streetAddr)")
                    
                    completion(streetAddr)
                }
            }
        }
    }
    
    
    public func getGeoCoord(address: String, completion: @escaping (CLLocation) -> Void){
        // forward geocoding
        let gc = CLGeocoder()
        
        gc.geocodeAddressString(address) { (result, err) in
            
            if let place = result?.first {
                if let loc = place.location {
                    print("Lat:\(loc.coordinate.latitude)")
                    completion(loc)
                }
            }
        }
    }
    
    
    
}
