//
//  BadgeView.swift
//  MobileGoRecruit
//
//  Created by Gustavo Silva on 8/28/23.
//

import SwiftUI

public struct BadgeView : View {
    internal init(value: Binding<Int>, x: Double = 30.0, y: Double = 4.0, foreground: Color = .white, background: Color = .red) {
        self._value = value
        self.x = x
        self.y = y
        self.foreground = foreground
        self.background = background
    }
    
    
    @Binding public var value: Int
    
    @State var x = 30.0
    @State var y = 4.0
    @State var foreground: Color = .white
    @State var background: Color = .red
    
    private let size = 20.0
    
   public var body: some View {
        ZStack {
            Capsule()
                .fill(background)
                .frame(width: size * widthMultplier(), height: size, alignment: .topTrailing)
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

