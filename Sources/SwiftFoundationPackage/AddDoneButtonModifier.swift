//
//  AddDoneButtonModifier.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/21/24.
//

import SwiftUI

@available(iOS 16.0, *)
public struct doneButtonModifier: ViewModifier {
    @FocusState public var isFieldFocused: Bool

    public func body(content: Content) -> some View {
        content
            .focused($isFieldFocused)
            .toolbar {
                if isFieldFocused {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isFieldFocused = false
                        }
                    }
                }
            }
           
    }
}

@available(iOS 16.0, *)
public extension View {
    func addDoneButton() -> some View {
        modifier(doneButtonModifier())
    }
}
