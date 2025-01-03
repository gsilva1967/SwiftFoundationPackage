//
//  MapLocation.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 5/17/23.
//

import Foundation
import MapKit

public struct MapLocation: Identifiable {
    public let id = UUID()
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let address: String
    public let imageName: String
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
