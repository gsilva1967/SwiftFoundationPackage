//
//  CheckBoxToggleStyle.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 1/2/25.
//

import Foundation
import SwiftUI

public struct CheckboxToggleStyle: ToggleStyle {
   public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark" : "")

        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
}

public extension ToggleStyle where Self == CheckboxToggleStyle {
     static var checkmark: CheckboxToggleStyle { CheckboxToggleStyle() }
}
