 
 
 import CoreLocation
 
 class UR_CLASS: CLLocationManagerDelegate {

    
    fileprivate var isSetLocation = false
    fileprivate lazy var locationManager: CLLocationManager = CLLocationManager()
    fileprivate var userLocation: CLLocation!{
        didSet{
            let coordinate = userLocation.coordinate
            let lat = coordinate.latitude
            let lng = coordinate.longitude  
        }
    }
    
    fileprivate func setupLocationManager(){
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }

    // Impl Methods
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.isSetLocation {
            self.isSetLocation = true
            self.userLocation = locations.last
        }
        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse, .authorizedAlways:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .restricted, .denied:
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
            break
        }
    }
    
}