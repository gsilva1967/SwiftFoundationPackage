//
//  MobileGoRecruit.swift
//  MobileGoRecruit
//
//  Created by Gustavo Silva on 1/18/23.
//

import SwiftUI

public struct InfoProgressView<Content: View>: View {
    let message: String
    var loadedCompelete: Bool
    let content: () -> Content

    public init(message: String, loadedCompelete: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.message = message
        self.loadedCompelete = loadedCompelete
        self.content = content
    }

    public var body: some View {
        ZStack {
            content()
                .blur(radius: loadedCompelete ? 0 : 3)

            VStack {
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                ProgressView()
            }
            .frame(width: 250, height: 100)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
            .opacity(loadedCompelete ? 0 : 1)
        }
        .allowsHitTesting(loadedCompelete ? true : false)
    }
}
