//
//  TextFieldLimitModifier.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 8/25/23.
//

import Combine
import SwiftUI

public struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    public var length: Int

    public init(value: Binding<String>?, length: Int) {
        self._value = value!
        self.length = length
    }
    public func body(content: Content) -> some View {
        content
            .onReceive(Just(value)) {
                value = String($0.prefix(length))
            }

    }
}

public extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
