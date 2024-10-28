//
//  BadgeViewLocal.swift
//  MobileGoRecruit
//
//  Created by Gustavo Silva on 8/28/23.
//

import SwiftUI

public struct BadgeViewLocal: View {
    @Binding public var value: Int

    @State public var x = 30.0
    @State public var y = 4.0
    @State public var foreground: Color = .white
    @State public var background: Color = .red
    @State public var usePosition: Bool = true

    public let size = 20.0

    public var body: some View {
        ZStack {
            if usePosition {
                Capsule()
                    .fill(background)
                    .frame(width: size * widthMultplier(), height: size, alignment: .trailing)
                    .position(x: x, y: y)

                if hasTwoOrLessDigits() {
                    Text("\(value)")
                        .foregroundColor(foreground)
                        .font(Font.caption)
                        .position(x: x, y: y)
                } else {
                    Text("99+")
                        .foregroundColor(foreground)
                        .font(Font.caption)
                        .frame(width: size * widthMultplier(), height: size, alignment: .center)
                        .position(x: x, y: y)
                }
            } else {
                Capsule()
                    .fill(background)
                    .frame(width: size * widthMultplier(), height: size, alignment: .trailing)

                if hasTwoOrLessDigits() {
                    Text("\(value)")
                        .foregroundColor(foreground)
                        .font(Font.caption)
                } else {
                    Text("99+")
                        .foregroundColor(foreground)
                        .font(Font.caption)
                        .frame(width: size * widthMultplier(), height: size, alignment: .center)
                }
            }
        }
        .opacity(value == 0 ? 0 : 1)
    }

    // showing more than 99 might take too much space, rather display something like 99+
    public func hasTwoOrLessDigits() -> Bool {
        return value < 100
    }

    public func widthMultplier() -> Double {
        if value < 10 {
            // one digit
            return 1.0
        } else if value < 100 {
            // two digits
            return 1.5
        } else {
            // too many digits, showing 99+
            return 2.0
        }
    }
}
