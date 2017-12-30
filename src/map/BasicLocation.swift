 
 
 import CoreLocation
 
 extension UR_CLASS: CLLocationManagerDelegate {

    
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
    
}