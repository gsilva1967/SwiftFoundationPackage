//
//  DateComponents.swift
//  SSAMobile
//
//  Created by Michael Kacos on 10/26/21.
//

import Foundation

public extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    func get14DaysFromToday() -> [daysOfWeek] {
        var rtnVal: [daysOfWeek] = []

        for i in 0 ... 13 {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: self)
            let components = modifiedDate!.get(.day)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfTheWeekString = dateFormatter.string(from: modifiedDate!)
            let dayOfWeekAbbr = dayOfTheWeekString.prefix(3).description.uppercased()

            let day = daysOfWeek(dayOfWeek: dayOfWeekAbbr, dayofMonth: components, isSelected: modifiedDate == self ? true : false, date: modifiedDate!)

            rtnVal.append(day)
        }

        return rtnVal
    }

    func get7DaysFromToday() -> [daysOfWeek] {
        var rtnVal: [daysOfWeek] = []

        for i in 0 ... 6 {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: i, to: self)
            let components = modifiedDate!.get(.day)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayOfTheWeekString = dateFormatter.string(from: modifiedDate!)
            let dayOfWeekAbbr = dayOfTheWeekString.prefix(3).description.uppercased()

            let day = daysOfWeek(dayOfWeek: dayOfWeekAbbr, dayofMonth: components, isSelected: modifiedDate == self ? true : false, date: modifiedDate!)

            rtnVal.append(day)
        }

        return rtnVal
    }

    var niceGreeting: String {
        let hour = Calendar.current.component(.hour, from: self)

        switch hour {
        case 0 ..< 12: return "Good Morning"
        case 12 ..< 17: return "Good Afternoon"
        case 17 ... 24: return "Good Evening"
        default: return "Hello"
        }
    }

    struct daysOfWeek {
        var dayOfWeek: String
        var dayofMonth: Int
        var isSelected: Bool
        var date: Date
    }

    func getCurrentYear() -> Int {
        return Calendar.current.component(.year, from: Date.now)
    }

//    func isInRange(startDate: Date, endDate: Date) -> Bool {
//        let newStart = Calendar.current.startOfDay(for: startDate)
//        let newEnd = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: 1, to: endDate)!)
//
//        let range = newStart...newEnd
//
//        if(range.contains(self))
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//
//
//
//    }
}
