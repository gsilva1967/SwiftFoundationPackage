//
//  TextFieldWithDone.swift
//  SwiftFoundationPackage
//
//  Created by Michael Kacos on 1/28/25.
//
import SwiftUI
import UIKit

public struct TextfieldWithDone: UIViewRepresentable {
    @Binding var text: String
    var keyType: UIKeyboardType
    
    public init(text: Binding<String>, keyType: UIKeyboardType = .default) {
        self._text = text
        self.keyType = keyType
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
      textfield.keyboardType = keyType
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        toolBar.items = [doneButton]
        toolBar.setItems([doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        return textfield
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}
