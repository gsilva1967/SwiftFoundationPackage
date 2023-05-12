//
//  Double+MileageConverter.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 4/25/23.
//

import Foundation

public extension Double {
    func convertForMileage(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> String {
        var rtnVal = ""
        var initialMeasurement: Double

        if self > 402.336 {
            initialMeasurement = Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
        } else {
            initialMeasurement = Measurement(value: self, unit: UnitLength.meters).converted(to: UnitLength.feet).value
            return String(format: "%.0f", ceil(initialMeasurement)) + " ft"
        }

        var roundedMeasurement = String(format: "%.1f", initialMeasurement) + " mi"

        if roundedMeasurement.suffix(5) == ".0 mi" {
            let substring = roundedMeasurement.dropLast(5)
            roundedMeasurement = substring.description + " mi"
        }

        rtnVal = roundedMeasurement
        return rtnVal
    }
}
