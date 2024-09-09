//
//  File.swift
//  
//
//  Created by Michael Kacos on 9/9/24.
//

import Foundation

import SwiftUI

public struct FoundationTextField: View {
    public var title: String
    public var minLength: Int = 0
    public var isRequired: Bool = false
    @Binding public var valueToBindTo: String
    
    public init(title: String, valueToBindTo: Binding<String>, minLength: Int = 0, isRequired: Bool = false) {
        self.title = title
        self.minLength = minLength
        self._valueToBindTo = valueToBindTo
        self.isRequired = isRequired
    }
    
    public var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            TextField(title, text: $valueToBindTo).clearButton(text: $valueToBindTo)
                .padding(isRequired == false ? 0 : valueToBindTo.isEmpty || (minLength != 0 && valueToBindTo.count < minLength) ? 6 : 0)
                .border(isRequired == false ? Color.clear : valueToBindTo.isEmpty || (minLength != 0 && valueToBindTo.count < minLength) ? Color.red : Color.clear)
        }
    }
}
