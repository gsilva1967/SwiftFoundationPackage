//
//  GenieRenderer.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 10/24/24.
//

import SwiftUICore

@available(iOS 17.0, *)
public struct GenieRenderer: TextRenderer {
    public var strength: Double
    

    public var animatableData: Double {
        get { strength }
        set { strength = newValue }
    }

    public func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for glyph in run {
                    let fontSize = strength 
                    var copy = context
                    
                    copy.scaleBy(x: 1.0, y: fontSize )
                    copy.draw(glyph)
                }
            }
        }
    }
}
