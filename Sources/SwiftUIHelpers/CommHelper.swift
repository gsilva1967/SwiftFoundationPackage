//
//  CommHelper.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 5/17/23.
//

import Foundation
import UIKit

public enum CommHelper {
    public static func getPhoneUrl(phone: String) -> URL {
        let phoneNumber = phone
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: ".", with: "")
        guard let number = URL(string: "tel://" + phoneNumber) else { return URL(string: "")! }

        return number
    }

    public static func callPhoneNumber(phone: String) {
        UIApplication.shared.open(getPhoneUrl(phone: phone))
    }

    public static func getFormattedNumber(phone: String) -> String {
        var rtnVal: String = phone
        if phone.count == 10 {
            let areaCode = phone.prefix(3)
            let start = phone.index(phone.startIndex, offsetBy: 3)
            let end = phone.index(phone.endIndex, offsetBy: -4)
            let range = start ..< end
            let exchange = phone[range]
            let last4 = phone.suffix(4)

            rtnVal = "(\(areaCode)) \(exchange)-\(last4)"
        }

        return rtnVal
    }
}
