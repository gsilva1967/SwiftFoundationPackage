//
//  FlyInRenderer.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/25/24.
//

import SwiftUICore

@available(iOS 17.0, *)
public struct FlyInRenderer: TextRenderer {
    public var xOffset: Double
    

    public var animatableData: Double {
        get { xOffset }
        set { xOffset = newValue }
    }

    public func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for (index, glyph) in run.enumerated() {
                    let offset = 0 - xOffset
                    var copy = context

                    copy.translateBy( x:offset, y: 0)
                    copy.draw(glyph, options: .disablesSubpixelQuantization)
                }
            }
        }
    }
}
