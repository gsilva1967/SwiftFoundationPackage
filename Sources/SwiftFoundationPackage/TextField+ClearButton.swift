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
                HStack {
                    Text(" ")
                }
                .clipShape(Rectangle())
                .onTapGesture {
                    // Does nothing on purpose to deal with the tap of the button opens the picker
                }
                .overlay(content: {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundStyle(.gray)
                        
                }
                .padding(.trailing, 4)
                .buttonStyle(PlainButtonStyle())
                })
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .layoutPriority(1)
            }
        }
    }
}

public extension View {
     func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}
