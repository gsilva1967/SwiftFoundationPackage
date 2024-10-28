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

public extension Optional where Wrapped == Int {
    var makeEmptyIfNil: String {
        if self == nil {
            return ""
        } else {
            return self!.description
        }
    }
    
    var displayOptionalText: String {
        return makeEmptyIfNil
    }
    
    var isNilOrZero: Bool {
        if(self == nil || self == 0){
            return true
        }
        return false
    }
}
