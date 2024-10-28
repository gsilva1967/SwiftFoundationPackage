//
//  CheckBoxToggleStyle.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 5/26/23.
//

import Foundation
import SwiftUI

public struct CheckboxToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark" : "")

//            RoundedRectangle(cornerRadius: 5.0)
//                .stroke(lineWidth: 2)
//                .frame(width: 25, height: 25)
//                .cornerRadius(5.0)
//                .overlay {
//                    Image(systemName: configuration.isOn ? "checkmark" : "")
//                }
//                .onTapGesture {
//                    withAnimation(.spring()) {
//                        configuration.isOn.toggle()
//                    }
//                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkmark: CheckboxToggleStyle { CheckboxToggleStyle() }
}
