//
//  TruncableText.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 6/28/23.
//

import SwiftUI

public struct TruncableText: View {
    public init(text: Text, lineLimit: Int? = nil, intrinsicSize: CGSize = .zero, truncatedSize: CGSize = .zero, isTruncatedUpdate: @escaping (Bool) -> Void) {
        self.text = text
        self.lineLimit = lineLimit
        self.intrinsicSize = intrinsicSize
        self.truncatedSize = truncatedSize
        self.isTruncatedUpdate = isTruncatedUpdate
    }
    
    public let text: Text
    public let lineLimit: Int?
    @State public var intrinsicSize: CGSize = .zero
    @State public var truncatedSize: CGSize = .zero
    public let isTruncatedUpdate: (_ isTruncated: Bool) -> Void

   public var body: some View {
        text
            .lineLimit(lineLimit)
            .readSize { size in
                truncatedSize = size
                isTruncatedUpdate(truncatedSize != intrinsicSize)
            }
            .background(
                text
                    .fixedSize(horizontal: false, vertical: true)
                    .hidden()
                    .readSize { size in
                        intrinsicSize = size
                        isTruncatedUpdate(truncatedSize != intrinsicSize)
                    }
            )
    }
}
