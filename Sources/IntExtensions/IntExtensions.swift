//
//  Int+Commas.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 4/7/23.
//

import Foundation

public extension Int {
    var withCommas: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
