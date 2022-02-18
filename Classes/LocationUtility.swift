

import Foundation
import CoreLocation


class LocationUtility : NSObject, CLLocationManagerDelegate {
    
    var lManager : CLLocationManager?
    public var currentLocation : CLLocation?
  
    public  override init() {
        
        
        lManager = CLLocationManager()
        lManager?.requestWhenInUseAuthorization()
        lManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        super.init()
        lManager?.delegate = self
        
    }
    public func startTracking(){
        
        lManager?.startUpdatingLocation()
    
    }
    
    public func stopTracking() {
        
            lManager?.stopUpdatingLocation()
    
    }
    
    
    // From delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("Location updated..")
        if let loc = locations.last {
            currentLocation = loc
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
            
            
        case .denied:
           
            print("Denied")
            
        case .authorizedWhenInUse:
           
            print("Granted")
            lManager?.startUpdatingLocation()
            
        default:
           
            print("Unknown auth")
        }
        
    }
}


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
