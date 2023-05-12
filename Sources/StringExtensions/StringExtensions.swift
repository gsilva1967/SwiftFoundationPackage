//
//  File.swift
//
//
//  Created by Mike Kacos on 10/20/20.
//

import Foundation
import UIKit
/**
 Extenstions for Strings
 
 - author: Michael Kacos
 - returns: Various

 */
public extension Optional where Wrapped == String {
    /**
     Determines if the string is numeric
     
     - author: Michael Kacos
     - returns: Bool
    
     */
    var isNumeric: Bool {
        if self == nil || self == "" {
            return false
        }
        else if Int(self!) != nil {
            return true
        }
        else if Double(self!) != nil {
            return true
        }
        else if Float(self!) != nil {
            return true
        }
        else {
            return false
        }
    }
    
    /**
     Returns if the string is nil or empty
     
     - author: Michael Kacos
     - returns: Bool
    
     */
    var isNilOrEmpty: Bool {
        if self == nil || self == "" {
            return true
        }
        else {
            return false
        }
    }
    
    /**
     Returns if the string is NOT nil or empty
     
     - author: Michael Kacos
     - returns: Bool
     
     */
    var isNotNilOrEmpty: Bool {
        if self == nil || self == "" {
            return false
        }
        else {
            return true
        }
    }
    
    /**
     Makes an optional string Nil if it is empty
     
     - author: Michael Kacos
     - returns: String?
    
     */
    var makeNilIfEmpty: String? {
        if self == "" {
            return nil
        }
        else {
            return self
        }
    }
    
    /**
     Makes an optional string empty if it is nil
     
     - author: Michael Kacos
     - returns: String?
     
     */
    var makeEmptyIfNil: String {
        if self == nil {
            return ""
        }
        else {
            return self!
        }
    }
    
    var displayOptionalText: String {
        return makeEmptyIfNil
    }
    
    func replaceForNil(replacement: String = "") -> String {
        if self == nil {
            return replacement
        }
        else {
            return self!
        }
    }
    
    var base64ToImage : UIImage? {
        if (self.isNotNilOrEmpty ) {
            let decodedData = NSData(base64Encoded: self!, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            if (decodedData != nil) {
                let decodedImage = UIImage(data: decodedData! as Data)
                return decodedImage!
            } else {
                return UIImage()
            }
        }
        return UIImage()
    }
}

public extension String {
    func slice(from: String, to: String) -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom ..< rangeTo])
    }
    
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
}
