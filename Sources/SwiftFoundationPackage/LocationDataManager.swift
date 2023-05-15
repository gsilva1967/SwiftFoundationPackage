//
//  LocationDataManager.swift
//  FirstResponderSystem (iOS)
//
//  Created by Michael Kacos on 5/3/23.
//

import CoreLocation
import Foundation
import UIKit

@available(iOS 16.0, *)
public class LocationDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    public var locationManager = CLLocationManager()
    @Published public var authorizationStatus: CLAuthorizationStatus?
    @Published public var locations: [CLLocation]?
    public var startLocation: CLLocation!
    @Published public var lastLocation: CLLocation!
    @Published public var traveledDistance: Double = 0
    public var startDate: Date!

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

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
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
            manager.requestWhenInUseAuthorization()

        default:
            break
        }
    }

    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates

        if startDate == nil {
            startDate = Date()
        }

        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            traveledDistance = startLocation.distance(from: location)
            if traveledDistance > 5 && Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate > 5
            {
                startLocation = location
                startDate = Date()
                self.locations = locations
                print("I moved 5 meters")
            } else {
                print("Traveled Distance:", startLocation.distance(from: location))
            }


        }
        lastLocation = locations.last
    }

    public func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
