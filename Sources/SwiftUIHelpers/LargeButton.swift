//
//  LargeButton.swift
//  Peraton Inc.
//
//  Created by Michael Kacos on 10/26/21.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct LargeButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let isDisabled: Bool

    public func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(borderColor, lineWidth: 1)
            )
            .padding([.top, .bottom], 10)
            .font(Font.system(.body).weight(.semibold))
    }
}

@available(iOS 16.0, *)
public struct LargeButton: View {
    private static let buttonHorizontalMargins: CGFloat = 0

    var backgroundColor: Color
    var foregroundColor: Color
    var borderColor: Color?

    private let title: String
    private let action: () -> Void

    // It would be nice to make this into a binding.
    private let disabled: Bool

    public init(title: String,
                disabled: Bool = false,
                backgroundColor: Color = Color.green,
                foregroundColor: Color = Color.white,
                borderColor: Color? = Color.white,
                action: @escaping () -> Void)
    {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.title = title
        self.action = action
        self.disabled = disabled
    }

    public var body: some View {
        HStack {
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
            Button(action: self.action) {
                Text(LocalizedStringKey(self.title))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          borderColor: borderColor != Color.white ? borderColor! : backgroundColor,
                                          isDisabled: disabled))
            .disabled(self.disabled)
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .frame(maxWidth: .infinity)
    }
}
