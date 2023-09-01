//
//  TextField+ClearButton.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 8/3/23.
//

import SwiftUI

public struct ClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 4)
            }
        }
    }
}

public extension View {
     func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}
