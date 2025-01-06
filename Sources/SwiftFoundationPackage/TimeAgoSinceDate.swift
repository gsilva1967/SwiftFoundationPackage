//
//  TimeAgoSinceDate.swift
//  MobileGoRecruit
//
//  Created by Gustavo Silva on 9/14/23.
//

import Foundation

public func timeAgoSinceDate(date: NSDate, numericDates: Bool) -> String {
    let calendar = Calendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date, to: latest as Date)

    if components.year! >= 2 {
        return "\(components.year!) years ago"
    } else if components.year! >= 1 {
        if numericDates {
            return "1 year ago"
        } else {
            return "last year"
        }
    } else if components.month! >= 2 {
        return "\(components.month!) months ago"
    } else if components.month! >= 1 {
        if numericDates {
            return "1 month ago"
        } else {
            return "last month"
        }
    } else if components.weekOfYear! >= 2 {
        return "\(components.weekOfYear!) weeks ago"
    } else if components.weekOfYear! >= 1 {
        if numericDates {
            return "1 week ago"
        } else {
            return "last week"
        }
    } else if components.day! >= 2 {
        return "\(components.day!) days ago"
    } else if components.day! >= 1 {
        if numericDates {
            return "1 day ago"
        } else {
            return "yesterday"
        }
    } else if components.hour! >= 2 {
        return "\(components.hour!) hours ago"
    } else if components.hour! >= 1 {
        if numericDates {
            return "1 hour ago"
        } else {
            return "an hour ago"
        }
    } else if components.minute! >= 3 {
        return "\(components.minute!) minutes ago"
    } else if components.minute! >= 1 {
        if numericDates {
            return "1 minute ago"
        } else {
            return "just now"
        }

    } else if components.second! >= 3 {
        return "just now" // "\(components.second!) seconds ago"
    } else {
        return "just now"
    }
}
