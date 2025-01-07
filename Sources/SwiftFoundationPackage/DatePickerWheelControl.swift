//
//  DatePickerWheelControl.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 11/21/23.
//

import SwiftUI

public struct DatePickerWheelControl: View {
    var title: String
    var startDate: Date = .init().addToDate(date: Date(), dateComponent: .year, interval: -100)
    var endDate: Date = .init().addToDate(date: Date(), dateComponent: .year, interval: 100)
    var foregroundColor: Color = .init(red: 107.0, green: 107.0, blue: 112.0)
    @Binding var dateToBind: Date

    public init(title: String, startDate: Date, endDate: Date, dateToBind: Binding<Date>?) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self._dateToBind = dateToBind!
    }

    public init(title: String, startDate: Date, endDate: Date, foregroundColor: Color, dateToBind: Binding<Date>?) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.foregroundColor = foregroundColor
        self._dateToBind = dateToBind!
    }

    public var body: some View {
        VStack {
            HStack {
                Text(title)

//                Spacer()
//                Text("\(dateToBind.formatDate(format: .shortDate))")
//                Image(systemName: "chevron.right")
            }
            .foregroundColor(foregroundColor)
            .contentShape(Rectangle())

            HStack {
                DatePicker("", selection: $dateToBind, in: startDate ... endDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .foregroundColor(foregroundColor)
                    .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
            }
        }
    }
}
