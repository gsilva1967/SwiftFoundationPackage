//
//  EditTextField2.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/1/24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public struct EditTextField: View {
    public var title: String
    public var placeholderText: String = ""
    public var minLength: Int = 0
    public var isRequired: Bool = false
    public var keyBoardType: UIKeyboardType = .default
    public var validationType: EditFieldValidation = .none
    var showWarning: Bool = false
    @State var validationMessage: String
    @Binding public var isValid: (String, Bool)
    @Binding public var valueToBindTo: String

    public init(title: String, placeholderText: String = "", valueToBindTo: Binding<String>, minLength: Int = 0, isRequired: Bool = false, keyBoardType: UIKeyboardType = .default, validationType: EditFieldValidation = .none, showWarning: Bool = false, isValid: Binding<(String, Bool)>? = .constant((.init(), true))) {
        self.title = title
        self.placeholderText = placeholderText.isEmpty ? title : placeholderText
        self.minLength = minLength
        self._valueToBindTo = valueToBindTo
        self.isRequired = isRequired
        self.showWarning = showWarning
        self.keyBoardType = keyBoardType
        self.validationType = validationType
        self.validationMessage = ""
        self._isValid = isValid!
    }

    public var body: some View {
        VStack {
            HStack {
                Text(self.validationMessage.count > 0 ? validationMessage : title)
                    .font(.caption2)
                    .foregroundColor(self.validationMessage.count > 0 ? .red : .primary)
                Spacer()
            }
            ZStack {
                HStack {
                    TextField(placeholderText, text: $valueToBindTo) // .clearButton(text: $valueToBindTo)
                        .foregroundColor(.secondary)
                        .padding(isValid.1 ? 0 : 6)
                        .overlay(isValid.1 ? nil : RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 0.33)
                        )
                        .keyboardType(keyBoardType)
                        .onChange(of: valueToBindTo) {
                            checkValidity()
                        }
                    Spacer()
                    if showWarning {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color(.systemOrange))
                            .font(.subheadline)
                    }
                }
            }
        }
    }

    public func checkValidity() {
        isValid = (title, true)
        validationMessage = ""

        if (isRequired == true && valueToBindTo.count == 0) || (minLength != 0 && valueToBindTo.count < minLength) {
            isValid.1 = false
            let newTitle = title.replacingOccurrences(of: "(required)", with: "")
            validationMessage = "\(newTitle) is required.  \(minLength != 0 ? "Minimum length is \(minLength)." : "")".replacingOccurrences(of: "  ", with: " ")
        }

        switch validationType {
        case .email:
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            if regex.firstMatch(in: valueToBindTo, options: [], range: NSRange(location: 0, length: valueToBindTo.count)) == nil {
                isValid.1 = false
                validationMessage = "Please enter a valid email address."
            }
        case .alpha:
            let decimalCharacters = CharacterSet.decimalDigits

            let decimalRange = valueToBindTo.rangeOfCharacter(from: decimalCharacters)

            if decimalRange != nil {
                isValid.1 = false
                validationMessage = "Please enter only letters.  No numbers or punctuation."
            }
        case .numeric:
            let letterCharacters = CharacterSet.letters

            let letterRange = valueToBindTo.rangeOfCharacter(from: letterCharacters)

            if letterRange != nil {
                isValid.1 = false
                validationMessage = "Please enter only numbers.  No letters."
            }
        case .regex(let regexString):
            let regex = try! NSRegularExpression(pattern: regexString, options: .caseInsensitive)
            if regex.firstMatch(in: valueToBindTo, options: [], range: NSRange(location: 0, length: valueToBindTo.count)) == nil {
                isValid.1 = false
                validationMessage = "Please enter a valid email address."
            }
        case .none:
            break
        }
    }
}

public enum EditFieldValidation: Hashable {
    case none
    case numeric
    case alpha
    case email
    case regex(String)
}
