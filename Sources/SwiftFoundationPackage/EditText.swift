//
//  EditText.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 12/8/23.
//
//  This is used to allow the user to insert the cursor at any location within an edit box and allows us to insert text at a specific location.

import SwiftUI
import UIKit

public struct UITextViewWrapperForInsert: UIViewRepresentable {
    public typealias UIViewType = UITextView

    @Binding var text: String
    var onDone: (() -> Void)?
    var onFocused: (() -> Void)?
    var onChangeValue: (() -> Void)?

    public func makeUIView(context: UIViewRepresentableContext<UITextViewWrapperForInsert>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = true
        textField.backgroundColor = UIColor.clear
        if onDone != nil {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    public func updateUIView(_ uiView: UITextView, context _: UIViewRepresentableContext<UITextViewWrapperForInsert>) {
        if uiView.text != text {
            uiView.text = text
        }
        if uiView.window != nil, !uiView.isFirstResponder, uiView.isFocused {
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, onDone: onDone, onFocused: onFocused, onChangeValue: onChangeValue)
    }

    public final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var onDone: (() -> Void)?
        var onFocused: (() -> Void)?
        var onChangeValue: (() -> Void)?

        init(text: Binding<String>, onDone: (() -> Void)? = nil, onFocused: (() -> Void)? = nil, onChangeValue: (() -> Void)? = nil) {
            self.text = text
            self.onDone = onDone
            self.onFocused = onFocused
            self.onChangeValue = onChangeValue
        }

        public func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            if let onChangeValue = onChangeValue {
                onChangeValue()
            }
        }

        public func textView(_ textView: UITextView, shouldChangeTextIn _: NSRange, replacementText text: String) -> Bool {
            if let onDone = onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return true
            }
            return true
        }

        public func textViewDidChangeSelection(_ textView: UITextView) {
            if let range = textView.selectedTextRange {
                Global.cursorPosition.start = textView.offset(from: textView.beginningOfDocument, to: range.start)
                Global.cursorPosition.end = textView.offset(from: textView.beginningOfDocument, to: range.end)
            }
        }

        public func textViewDidBeginEditing(_ textView: UITextView) {
            if let range = textView.selectedTextRange {
                Global.cursorPosition.start = textView.offset(from: textView.beginningOfDocument, to: range.start)
                Global.cursorPosition.end = textView.offset(from: textView.beginningOfDocument, to: range.end)
            }
        }

        public func textViewShouldBeginEditing(_: UITextView) -> Bool {
            if let onFocused = onFocused {
                onFocused()
                return true
            }
            return true
        }
    }
}

public struct EditText: View {
    public var placeholder: String
    public var onCommit: (() -> Void)?
    var onFocused: (() -> Void)?
    var onChangeValue: (() -> Void)?

    @Binding public var text: String
    public var internalText: Binding<String> {
        Binding<String>(get: { self.text }) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State public var showingPlaceholder = false

    public init(_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil, onFocused: (() -> Void)? = nil, onChangeValue: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self.onFocused = onFocused
        self.onChangeValue = onChangeValue
        _text = text
        _showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    public var body: some View {
        UITextViewWrapperForInsert(text: internalText, onDone: onCommit, onFocused: onFocused, onChangeValue: onChangeValue)
            .background(placeholderView, alignment: .topLeading)
    }

    public var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

public enum Global {
    public static var cursorPosition = CursorPosition(start: 0, end: 0)
}

public struct CursorPosition {
    var start: Int
    var end: Int
}
