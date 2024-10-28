//
//  QuakeRenderer.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/24/24.
//

import SwiftUICore

@available(iOS 17.0, *)
public struct QuakeRenderer: TextRenderer {
    public var moveAmount: Double

    public var animatableData: Double {
        get { moveAmount }
        set { moveAmount = newValue }
    }

    public func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for glyph in run {
                    var copy = context
                    let yOffset = Double.random(in: -moveAmount...moveAmount)

                    copy.translateBy(x: 0, y: yOffset)
                    copy.draw(glyph, options: .disablesSubpixelQuantization)
                }
            }
        }
    }
}
