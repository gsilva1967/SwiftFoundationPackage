//
//  TapToTempZoomModifier.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 11/25/24.
//

import Combine
import SwiftUI

public struct TapToZoomModifier: ViewModifier {
    
    var normalFont: Font
    var largeFont: Font
    @State var textFont: Font = .caption
    
    public func body(content: Content) -> some View {
        content
            .font(textFont)
            .onTapGesture {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatCount(1, autoreverses: true)) {
                    textFont = largeFont
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatCount(1, autoreverses: true)) {
                        textFont = normalFont
                    }
                }
            }
            .onAppear {
                textFont = normalFont
            }
    }
}

public extension View {
    func tapToZoom( normalFont: Font, largeFont: Font) -> some View {
        modifier(TapToZoomModifier(normalFont: normalFont, largeFont: largeFont))
    }
}
