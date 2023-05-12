//
//  Int+Commas.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 4/7/23.
//

import Foundation

extension Int {
    var withCommas: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
