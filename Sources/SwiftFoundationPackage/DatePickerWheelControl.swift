//
//  DatePickerWheelControl.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 11/21/23.
//

import SwiftUI

public struct DatePickerWheelControl: View {
    var title: String
    var startDate: Date = Date().addToDate(date: Date(), dateComponent: .year, interval: -100)
    var endDate: Date = Date().addToDate(date: Date(), dateComponent: .year, interval: 100)
    var foregroundColor: Color = Color(red: 107.0, green: 107.0, blue: 112.0)
    @Binding var dateToBind: Date
    @State var showDatePicker = false
    
    init(title: String, startDate: Date, endDate: Date, foregroundColor: Color, dateToBind: Binding<Date>?, showDatePicker: Bool = false) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.foregroundColor = foregroundColor
        self._dateToBind = dateToBind!
        self.showDatePicker = showDatePicker
    }

    public var body: some View {
        VStack {
            HStack {
                Text(title)

                Spacer()
                Text("\(dateToBind.formatDate(format: .shortDate))")
                Image(systemName: "chevron.right")
            }
            .foregroundColor(foregroundColor)
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                showDatePicker.toggle()
            })

            if showDatePicker {
                HStack {
                    DatePicker("", selection: $dateToBind, in: startDate ... endDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .foregroundColor(foregroundColor)
                        .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                }
            }
        }
    }
}


