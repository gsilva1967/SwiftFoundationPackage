//
//  SwiftUIView.swift
//
//
//  Created by Mike Kacos on 10/19/20.
//

import SwiftUI

@available(iOS 16.0, *)
public struct FloatingLabelTextField: View {
    var title: String
    var text: Binding<String>
    var axis: Axis = .vertical

    @State var offset: CGFloat = 0

    public init(title: String, text: Binding<String>, axis: Axis = .vertical) {
        self.title = title
        self.text = text
        self.axis = axis
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(text.wrappedValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: offset)
                .scaleEffect(text.wrappedValue.isEmpty ? 1 : 0.65, anchor: .leading)
                .animation(.spring(response: 0.4, dampingFraction: 0.3), value: offset)

            TextField("", text: text, axis: axis)
                .background(GeometryReader { gp -> Color in
                    let rect = gp.frame(in: .named("OuterV")) // < in specific container
                    self.offset = text.wrappedValue.isEmpty ? 0 : ((rect.height / 2) + 20) * -1
                    return Color.clear
                })
        }
        .padding(.vertical)
        .coordinateSpace(name: "OuterV")
    }
}
