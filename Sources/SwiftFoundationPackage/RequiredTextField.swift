//
//  RequiredTextField.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 9/1/23.
//

import SwiftUI

public struct RequiredTextField: View {
    public var title: String
    public var minLength: Int = 0
    @Binding public var valueToBindTo: String
    
    public init(title: String, valueToBindTo: Binding<String>, minLength: Int = 0) {
        self.title = title
        self.minLength = minLength
        self._valueToBindTo = valueToBindTo
    }
    
    public var body: some View {
        TextField(title, text: $valueToBindTo).clearButton(text: $valueToBindTo)
            .padding(  valueToBindTo.isEmpty || (minLength != 0 && valueToBindTo.count < minLength) ? 6 : 0)
            .border(valueToBindTo.isEmpty || (minLength != 0 && valueToBindTo.count < minLength) ? Color.red : Color.clear)
    }
}


