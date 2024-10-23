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
                    HStack{
                        Spacer()
                        Image(systemName: "multiply.circle.fill")
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 60, height:  .infinity)
                        
                }
                //.padding(.trailing, 4)
                .contentShape(Rectangle())
                
            }
        }
    }
}

public extension View {
     func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}
