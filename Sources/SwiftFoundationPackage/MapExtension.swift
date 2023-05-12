//
//  MapExtension.swift
//  FirstResponderSystem (iOS)
//
//  Created by Michael Kacos on 9/2/22.
//

import Foundation
import MapKit
import SwiftUI

@available(iOS 16.0, *)
public extension Map {
    func mapStyle(_ mapType: MKMapType, showScale: Bool = true, showTraffic: Bool = false) -> some View {
        let map = MKMapView.appearance()
        map.mapType = mapType
        map.showsScale = showScale
        map.showsTraffic = showTraffic
        return self
    }

    func addAnnotations(_ annotations: [MKAnnotation]) -> some View {
        MKMapView.appearance().addAnnotations(annotations)
        return self
    }

    func addOverlay(_ overlay: MKOverlay) -> some View {
        MKMapView.appearance().addOverlay(overlay)
        return self
    }
}
