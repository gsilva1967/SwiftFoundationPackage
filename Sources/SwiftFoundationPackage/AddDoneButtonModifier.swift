//
//  AddDoneButtonModifier.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/21/24.
//

import SwiftUI

public struct doneButtonModifier: ViewModifier {
    @FocusState public var isFieldFocused: Bool

    public func body(content: Content) -> some View {
        content
            .focused($isFieldFocused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isFieldFocused = false
                    }
                }
            }
    }
}

public extension View {
    func addDoneButton() -> some View {
        modifier(doneButtonModifier())
    }
}
