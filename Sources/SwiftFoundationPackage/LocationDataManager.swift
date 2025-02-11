//
//  LocationDataManager.swift
//  FirstResponderSystem (iOS)
//
//  Created by Michael Kacos on 5/3/23.
//

@preconcurrency import CoreLocation
import Foundation
import UIKit


@available(iOS 17.0, *)
@MainActor
public class LocationDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    public var locationManager = CLLocationManager()
    @Published public var authorizationStatus: CLAuthorizationStatus?
    @Published public var locations: [CLLocation]?
    @Published public var lastLocation: CLLocation!
    @Published public var addressLocation : CLLocationCoordinate2D?
    
    public override init() {
        super.init()
        UIDevice.current.isBatteryMonitoringEnabled = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = UIDevice.current.batteryState != .unplugged ? kCLLocationAccuracyBestForNavigation : kCLLocationAccuracyBest
        locationManager.distanceFilter = 5
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }

    nonisolated public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task {
            await changeMyAuthorization(status: manager.authorizationStatus)
            if(manager.authorizationStatus == .notDetermined){
                manager.requestWhenInUseAuthorization()
            }
        }
    }
    
    public func changeMyAuthorization(status: CLAuthorizationStatus ) {
        switch status {
        case .authorizedAlways: // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedAlways
            locationManager.startUpdatingLocation()

        case .authorizedWhenInUse: // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.startUpdatingLocation()

        case .restricted: // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted

        case .denied: // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied

        case .notDetermined: // Authorization not determined yet.
            authorizationStatus = .notDetermined
            

        default:
            break
        }
    }

    nonisolated public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task{
            await updateLastLocation(locations: locations)
        }
    }
    
    public func updateLastLocation(locations: [CLLocation]) {
        // Insert code to handle location updates
        lastLocation = locations.last
    }

    nonisolated public func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    
    
    public func convertAddress(address: String) {
            getCoordinate(addressString: address) { (location, error) in
                if error != nil {
                    //handle error
                    return
                }
                DispatchQueue.main.async {
                    self.addressLocation = location
                }
            }
        }
        
        public func getCoordinate(addressString : String,
                completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        let location = placemark.location!
                            
                        completionHandler(location.coordinate, nil)
                        return
                    }
                }
                    
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
}
