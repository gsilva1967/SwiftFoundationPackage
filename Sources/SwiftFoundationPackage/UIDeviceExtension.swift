//
//  UIDevice+Idiom.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 1/12/23.
//

import Foundation
import UIKit

@available(iOS 16.0, *)
public extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isMac: Bool {
        UIDevice.current.userInterfaceIdiom == .mac
    }
}
