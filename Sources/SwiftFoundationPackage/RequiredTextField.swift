//
//  RequiredTextField.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 9/1/23.
//

import SwiftUI

public struct RequiredTextField: View {
    public var title: String
    @Binding var valueToBindTo: String
    
    public var body: some View {
        TextField(title, text: $valueToBindTo).clearButton(text: $valueToBindTo)
            .padding(  valueToBindTo.isEmpty ? 6 : 0)
            .border(valueToBindTo.isEmpty ? Color.red : Color.clear)
    }
}


