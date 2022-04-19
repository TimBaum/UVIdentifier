//
//  LocationManager.swift
//  uv.identifier
//
//  Created by Tim Baum on 18.03.22.
//

import MapKit
/**
 Manages the location of the user
 */
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    @Published var region: MKCoordinateRegion?
    @Published var city: String?
    @Published var country: String?
    
    /**
    Check if location services are enabled
     */
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        else {
            print("Location Services Unavailable")
        }
    }
    
    /**
     Ask for permission or if permission is granted update city and country based on the location
     */
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                print("Location is restricted")
            case .denied:
                print("Location is denied")
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = locationManager.location {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                updateCityAndCountry()
                } else {
                    print("Location nil")
                }
        @unknown default:
            break
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    /**
     update the city and country using CLGeocoder
     */
    func updateCityAndCountry() {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: region!.center.latitude, longitude: region!.center.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { [self] (placemarks, error) -> Void in
                        
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            self.country = placeMark.country
            self.city = placeMark.locality
            print(country!, city!)
        })
    }
}
