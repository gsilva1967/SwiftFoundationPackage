//
//  UIDevice+Idiom.swift
//  FirstResponderSystem
//
//  Created by Michael Kacos on 1/12/23.
//

import Foundation
import UIKit

public extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
