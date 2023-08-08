//
//  File.swift
//
//
//  Created by Mike Kacos on 12/3/20.
//

import Foundation

/**
 This class provides a base date formatter which is set to use US as its locale

 - author: Michael Kacos
 - warning: Should be used for locales outside of the US

 # Notes: #
 1. needed for extensions of dates
 */

public class localAdjustedDateformatter: DateFormatter {
    override public init() {
        super.init()
        timeZone = TimeZone.current
        locale = Locale(identifier: "en_US_POSIX")
    }

    public required init?(coder _: NSCoder) {
        super.init()
    }
}

public class gmtAdjustedDateformatter: DateFormatter {
    override public init() {
        super.init()
        timeZone = TimeZone(secondsFromGMT: 0)
        locale = Locale(identifier: "en_US_POSIX")
    }

    public required init?(coder _: NSCoder) {
        super.init()
    }
}

/// This going to be date format help
public enum DateFormat: String, Codable, CaseIterable {
    /// returns Mon, Tue, Etc.
    case weekDayShortName = "E"
    /// returns Monday, tuesday, Etc.
    case weekDayLongName = "EEEE"
    /// returns 01, 02, etc.
    case dayOfMonth = "dd"
    /// returns Monday Jan 4, 2021
    case longDate = "EEEE MMM d, yyyy"
    /// returns Jan 4, 2021
    case threeCharMonthDateYear = "MMM d, yyyy"
    /// returns Jan 4
    case threeCharMonthDay = "MMM d"
    /// returns Jan, Feb, Etc.
    case threeCahrMonth = "MMM"
    /// returns Monday, January 4
    case longDayLongMonth = "EEEE, MMMM d"
    /// returns Tuesday 08/12 | 10:20 AM
    case longDayShortMonthYearAndTime = "EEEE MM/dd | HH:mm"
    /// returns 24 hour time string: 14:49
    case timeIn24HourFormat = "HH:mm"
    /// returns 24 hour time string: 2:49 PM
    case timeWithAmPm = "h:mm a"
    /// returns 4 January 2021
    case militaryLongDate = "dd MMMM yyyy"
    /// returns 02/01/2023 @ 2:49
    case shortDateAtTime = "MM/dd/yyyy @ HH:mm"
    /// returns 02/01/2023 @ 2:49:35
    case shortDateAtTimeAndSeconds = "MM/dd/yyyy @ HH:mm:ss"
    /// returns 02/01/2023 2:49:35
    case shortDateTimeAndSeconds = "MM/dd/yyyy HH:mm"
    /// returns 10:45:28
    case hoursMinutesSeconds = "HH:mm:ss"
    /// returns 02/01/2023
    case shortDate = "MM/dd/yyyy"
    /// returns 2023-02-25T21:35:22
    case yearMonthDayWithTimeAndSeconds = "yyyy-MM-dd'T'HH:mm:ss"
    /// returns 2023-02-25 21:35:22
    case yearMonthDayWithTimeAndSecondsNoT = "yyyy-MM-dd HH:mm:ss"
}

public enum DateComponentEnum {
    case month,
         day,
         year
}

/**
 Date Extensions commonly used

 - author: Michael Kacos
 - warning: These are based off the gmtAdjustedDateFormmater which is set for a US locale

 */
public extension Date {
    func formatDate(format: DateFormat, uselocalDateTimeFormatter: Bool = false) -> String {
        let formatter = uselocalDateTimeFormatter ? localAdjustedDateformatter() : gmtAdjustedDateformatter() 
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }

    /**
     Returns a date with no time associated with it

     - author: Michael Kacos
     - returns: Date
     */
    var dateOnlyNoTimeAsDate: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let modifiedDate = calendar.startOfDay(for: self)
        return modifiedDate
    }

    // Brought over from DateHelper
    /**
     Takes a string and returns a formatted date based on the format of the string passed

     - author: Michael Kacos
     - parameter dateString: String.
     - returns: Date

     # Notes: #
     1. Originally in DateHelper class
     */
    func getDateFromString(dateString: String) -> Date {
        let dateFormatter = gmtAdjustedDateformatter()

        if dateString.count == 19 {
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        }
        if dateString.count == 20 {
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        } else if dateString.count == 21 {
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.S"
        } else if dateString.count == 22 {
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SS"
        } else if dateString.count == 23 {
            dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSZ"
        } else if dateString.count == 10 {
            dateFormatter.dateFormat = "YYYY-MM-dd"
        }
        

        let date = dateFormatter.date(from: dateString as String)

        return date!
    }

    /**
     Returns the day of the week string: Monday

     - author: Michael Kacos
     - parameter dateString: String.
     - returns: String

     # Notes: #
     1. Don't be fooled by the Index - 1.  That is necessary because of the diffence between the
     return of the weekday compnent and the array of weekdaySymbols
     */
    func getDayOfWeekFromString(dateString: String) -> String {
        let date = getDateFromString(dateString: dateString)

        let index = Calendar.current.component(.weekday, from: date)
        return Calendar.current.weekdaySymbols[index - 1] //
    }

    /**
     Returns the day of the month as a string

     - author: Michael Kacos
     - parameter dateString: String.
     - returns: String

     */
    func getDayOfMonthFromString(dateString: String) -> String {
        let date = getDateFromString(dateString: dateString)

        let index = Calendar.current.component(.day, from: date)
        return index.description
    }

    var getYearFromDate: Int {
        let year = Calendar(identifier: .gregorian).dateComponents([.year], from: self).year
        return year!
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    /**
     Returns an array of dates

     - author: Michael Kacos
     - parameter from: Date.
     - parameter to: Date.
     - returns: Array of dates [Date]
     */
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            let calendar = Calendar(identifier: .gregorian)
            // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
            tempDate = calendar.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate) // .dateWithOutTime)
        }

        return array
    }

    /**
     Simple enum that gives the varions times of date components

     - author: Michael Kacos

     # Notes: #
     1. <#Notes if any#>
     */

    /**
     Function that lets you add to a date component to get a new date

     - author: Michael Kacos
     - parameter date: Date.
     - parameter dateComponent: DateComponentEnum.
     - parameter interval: Int.
     - returns: Date

     # Notes: #
     1. <#Notes if any#>
     */
    func addToDate(date: Date, dateComponent: DateComponentEnum, interval: Int) -> Date {
        var dateComponents = DateComponents()

        switch dateComponent {
        case .month:
            dateComponents.month = interval
        case .day:
            dateComponents.day = interval
        case .year:
            dateComponents.year = interval
        }

        let futureDate = Calendar.current.date(byAdding: dateComponents, to: date)
        return futureDate ?? Date()
    }

    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current

        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "H:mm:ss"

            return dateFormatter.string(from: date)
        }
        return nil
    }

    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"

            return dateFormatter.string(from: date)
        }
        return nil
    }

    func getDateDiff(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    func compareDates(date1: Date, date2: Date) -> (display: String, greaterThan24Hours: Bool) {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: date1, to: date2)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        let seconds = diffComponents.second

        let printHours = String(format: "%02d", abs(hours!))
        let printMinutes = String(format: "%02d", abs(minutes!))
        let printseconds = String(format: "%02d", abs(seconds!))

        if abs(hours!) > 0, hours != nil {
            if abs(hours!) > 24 {
                return (date1.formatDate(format: .shortDateAtTime), true)
            } else {
                return (String(format: "%@:%@:%@", printHours, printMinutes, printseconds), false)
            }
        } else {
            return (String(format: "%@:%@", printMinutes, printseconds), false)
        }
    }

    func getHoursDifference(fromDate: Date, toDate: Date) -> Int? {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: fromDate, to: toDate)
        return diffComponents.hour
    }

    func getFriendlyDate(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return date.formatDate(format: .timeWithAmPm)
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return date.formatDate(format: .shortDate)
        }
    }

    func getGreetingText() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0 ..< 12: return "Good Morning"
        case 12 ..< 17: return "Good Afternoon"
        case 17 ..< 24: return "Good Evening"
        default: return "Hello"
        }
    }
    
    var localTimeZoneDateTime: Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: Date()))
        return Date(timeInterval: seconds, since: Date())
    }
}
