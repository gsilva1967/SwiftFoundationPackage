//
//  DatePickerOptional.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 9/1/23.
//

import SwiftUI
import DateExtensions

public struct DatePickerOptional: View {
    var placeholderText: String
    var title: String
    var showWarning: Bool = false
    @Binding var dateToBindTo: Date?
    @State var yearsToStartBack: Int = 0
    @State var showDatePicker: Bool = false
    
   public init(placeholderText: String, title: String, showWarning: Bool = false, dateToBindTo: Binding<Date?>?, yearsToStartBack: Int = 0, showDatePicker: Bool = false) {
        self.placeholderText = placeholderText
        self.title = title
        self.showWarning = showWarning
        self._dateToBindTo = dateToBindTo!
        self.yearsToStartBack = yearsToStartBack
        self.showDatePicker = showDatePicker
    }

   public var body: some View {
        if dateToBindTo == nil {
            HStack {
                Text(title)
                Spacer()
                if showWarning {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color(.systemOrange))
                        .font(.subheadline)
                        .padding(.trailing, 4)
                }
                Text(placeholderText)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color(.systemFill)).opacity(0.8)
                    .foregroundColor(.secondary)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1 / 3)
                            .opacity(0.3)
                    )
                    .onTapGesture {
                        dateToBindTo = getBindDate()
                        showDatePicker = true
                    }
            }
        } else {
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.caption2)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                            Spacer()
                        }
                        HStack {
                            Text("\(dateBinding.wrappedValue.formatDate(format: .shortDate))")
                                .foregroundColor(.secondary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.callout)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                .contentShape(Rectangle())
                .onTapGesture(perform: {
                    showDatePicker.toggle()
                })

                if showDatePicker {
                    HStack {
                        DatePicker("",
                                   selection: dateBinding,
                                   in: getDateRange(),
                                   displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .foregroundColor(Color("PlaceholderColor"))
                            .environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
                    }
                }
            }
        }
    }

    public var dateBinding: Binding<Date> {
        Binding {
            (dateToBindTo == nil ? getBindDate() : dateToBindTo!)!
        } set: {
            dateToBindTo = $0
        }
    }

    public func getDateRange() -> ClosedRange<Date> {
        var yearsBack = 100
        if yearsToStartBack > 0 {
            yearsBack = -yearsToStartBack
        }

        let startDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        let endDate = Calendar.current.date(byAdding: .year, value: yearsBack, to: Date())!
        return startDate ... endDate
    }

    public func getBindDate() -> Date? {
        if yearsToStartBack > 0 {
            return Calendar.current.date(byAdding: .year, value: -yearsToStartBack, to: Date())!
        }
        return Date()
    }
}

