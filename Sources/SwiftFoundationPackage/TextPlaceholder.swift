//
//  TextPlaceholder.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 8/23/23.
//

import SwiftUI

public struct TextPlaceholder: View {
    public let text: String
    public let placeholder: String

    public init(text: String, placeholder: String) {
        self.placeholder = placeholder
        self.text = text
    }

    public var body: some View {
        if text.isEmpty {
            Text(placeholder)
                .foregroundColor(.secondary.opacity(0.6))
        } else {
            Text(text)
        }
    }
}
