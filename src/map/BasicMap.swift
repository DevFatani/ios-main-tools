

import UIKit
import GoogleMaps

class UR_CLASS: UIViewController, GMSMapViewDelegate { 

    var objects = [Object]()
    @IBOutlet weak var googleMapsView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let styleURL =  Bundle.main.url(forResource: "map_style", withExtension: "json") {
            if let style = try? GMSMapStyle(contentsOfFileURL: styleURL){
                self.googleMapsView.mapStyle = style
            }
        }
    }

    private func addMarkerBy(objects:[Object]){
        for object in self.objects {
           let coordinate =  CLLocationCoordinate2DMake(object.lat, object.lng)
           let marker = GMSMarker(position: coordinate)
           marker.icon = Tools.replaceMarkerWith("YOUR_IMAGE", 0.5)
           marker.map = self.googleMapsView
        }
    }

    private func addSingleMarker(_ location: (lat: Double, lng: Double)){
        let coordinate =  CLLocationCoordinate2DMake(location.lat, location.lng)
        let marker = GMSMarker(position: coordinate)
        marker.map = self.googleMapsView
        self.googleMapsView.animate(to: GMSCameraPosition.camera( withTarget:coordinate, zoom: 17.0))
    }


    // Impl Methods
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        for object in self.objects {
                let position = marker.position
                if placeTo.lat == position.latitude && placeTo.lng == position.longitude {
                    self.performSegue(withIdentifier: "Show Popup Order", sender: order)
                    return true
                }
            }
        return false
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapsView.isMyLocationEnabled = true
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }

    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        print("\(#function)")
        print("placeID: \(placeID), name: \(name), location: \(location.latitude), \(location.longitude)")
    }


    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.marker?.position = position.target
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }   
}