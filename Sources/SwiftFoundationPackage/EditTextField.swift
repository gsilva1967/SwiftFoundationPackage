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
    @State var isValid: Bool = true
    @Binding public var valueToBindTo: String
    
    public init(title: String, placeholderText: String = "",valueToBindTo: Binding<String>, minLength: Int = 0, isRequired: Bool = false, keyBoardType: UIKeyboardType = .default, validationType: EditFieldValidation = .none, showWarning: Bool = false) {
        self.title = title
        self.placeholderText = placeholderText.isEmpty ? title : placeholderText
        self.minLength = minLength
        self._valueToBindTo = valueToBindTo
        self.isRequired = isRequired
        self.showWarning = showWarning
        self.keyBoardType = keyBoardType
        self.validationType = validationType
        self.validationMessage = ""
    }
    
    public var body: some View {
        VStack{
            HStack{
                Text(self.validationMessage.count > 0 ? validationMessage : title)
                    .font(.caption2)
                    .foregroundColor(self.validationMessage.count > 0 ? .red : .secondary)
                Spacer()
                
            }
            ZStack{
                HStack{
                    TextField(placeholderText, text: $valueToBindTo)//.clearButton(text: $valueToBindTo)
                        .padding(isValid ? 0 : 6)
                        .overlay( isValid ?
                                  nil
                                  :
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 0.33)
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
                
//                if(self.validationMessage.count > 0){
//                    HStack{
//                        Text(validationMessage)
//                        Spacer()
//                    }
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 5)
//                    .padding(.vertical, 4)
//                    .background(RoundedRectangle(cornerRadius: 13.0).fill(Color(.red).opacity(0.7)))
//                    .offset(y: -34)
//                }
            }
        }
        
        
    }
    
    public func checkValidity() {
        isValid = true
        self.validationMessage = ""
        
        if ((isRequired == true && valueToBindTo.count == 0) || (minLength != 0 && valueToBindTo.count < minLength)){
            self.isValid = false
            let newTitle = title.replacingOccurrences(of: "(required)", with: "")
            self.validationMessage = "\(newTitle) is required.  \(minLength != 0 ? "Minimum length is \(minLength)." : "")".replacingOccurrences(of: "  ", with: " ")
        }
        
        if(validationType == .alpha ){
            let decimalCharacters = CharacterSet.decimalDigits

            let decimalRange = valueToBindTo.rangeOfCharacter(from: decimalCharacters)

            if decimalRange != nil {
                self.isValid = false
                self.validationMessage = "Please enter only letters.  No numbers or punctuation."
            }
        }
        
        if(validationType == .numeric){
            let letterCharacters = CharacterSet.letters

            let letterRange = valueToBindTo.rangeOfCharacter(from: letterCharacters)

            if letterRange != nil {
                self.isValid = false
                self.validationMessage = "Please enter only numbers.  No letters."
            }
        }
        
        
    }
   
    
}

public enum EditFieldValidation: String, CaseIterable {
    case none
    case numeric
    case alpha
        
}

