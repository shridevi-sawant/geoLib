

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


