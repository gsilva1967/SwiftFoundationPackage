//
//  DateOptional+Extentions.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 6/24/24.
//

import Foundation

public extension Optional where Wrapped == Date {
    var topOfHour: Date? {
        get {
            if let theDate = self {
                let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: theDate)

                var newComponents = DateComponents()
                newComponents.year = components.year
                newComponents.month = components.month
                newComponents.day = components.day
                newComponents.hour = components.hour
                newComponents.minute = 0

                return Calendar.current.date(from: newComponents)
            } else {
                return nil
            }
        }
        set {
            self = newValue
        }
    }

    var optionalDateValue: Date {
        get {
            if self != nil {
                return self!
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale.autoupdatingCurrent
                dateFormatter.timeZone = TimeZone.current
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                return dateFormatter.date(from: "2099-12-31T23:59:59.999999")!
            }
        }
        set {
            self = newValue
        }
    }
}
