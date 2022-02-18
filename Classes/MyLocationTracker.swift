

import CoreLocation

//possible errors
enum OneShotLocationManagerErrors: Int {
    case AuthorizationDenied
    case AuthorizationNotDetermined
    case InvalidLocation
}

public class OneShotLocationManager: NSObject, CLLocationManagerDelegate {
    
    //location manager
    private var locationManager: CLLocationManager?
    
    //destroy the manager
    deinit {
        locationManager?.delegate = nil
        locationManager = nil
    }
    
   public typealias LocationClosure = ((_ location: CLLocation?, _ error: NSError?)->())
    private var didComplete: LocationClosure?
    
    //location manager returned, call didcomplete closure
    private func _didComplete(location: CLLocation?, error: NSError?) {
        locationManager?.stopUpdatingLocation()
        didComplete?(location, error)
        locationManager?.delegate = nil
        locationManager = nil
    }
    
   
    //location authorization status changed
    private func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse:
            self.locationManager!.startUpdatingLocation()
        case .denied:
            _didComplete(location: nil, error: NSError(domain: self.classForCoder.description(),
                                             code: OneShotLocationManagerErrors.AuthorizationDenied.rawValue,
                                             userInfo: nil))
        default:
            break
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _didComplete(location: nil, error: error as NSError)
    }
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        _didComplete(location: location, error: nil)
    }
    
    
    //ask for location permissions, fetch 1 location, and return
   public func fetchWithCompletion(completion: @escaping LocationClosure) {
        //store the completion closure
        didComplete = completion
        
        //fire the location manager
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
//        locationManager!.requestWhenInUseAuthorization()
        
    }
}
