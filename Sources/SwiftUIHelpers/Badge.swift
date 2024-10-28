//
//  Badge.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 1/15/24.
//

import Foundation
import SwiftUI

public struct Badge: View {
    let count: Int
    var useNumber: Bool = false

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            if count > 0 {
                Text(String(useNumber ? count.description : ""))
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    // custom positioning in the top-right corner
                    .alignmentGuide(.top) { $0[.bottom] - 10 }
                    .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
            }
        }
    }
}
