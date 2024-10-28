//
//  WaveRenderer.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/24/24.
//

import SwiftUICore

@available(iOS 17.0, *)
public struct WaveRenderer: TextRenderer {
    public var strength: Double
    public var frequency: Double

    public var animatableData: Double {
        get { strength }
        set { strength = newValue }
    }

   public func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (index, glyph) in run.enumerated() {
                    let yOffset = strength * sin(Double(index) * frequency)
                    var copy = context

                    copy.translateBy(x: 0, y: yOffset)
                    copy.draw(glyph, options: .disablesSubpixelQuantization)
                }
            }
        }
    }
}
