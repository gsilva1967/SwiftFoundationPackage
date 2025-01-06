//
//  SpotlightSearchView.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 8/14/23.
//

import SwiftUI

public struct SpotlightSearchView: View {
    @State var isRotated: Bool = false
    public var title: String
    public var title2: String

    public init(isRotated: Bool, title: String, title2: String) {
        self.isRotated = isRotated
        self.title = title
        self.title2 = title2
    }
    
    public var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.3.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .foregroundColor(.primary)
                    .mask {
                        Circle()
                            .offset(x: isRotated ? -75 : 75)
                            .animation(
                                .easeInOut(duration: 2)
                                    .repeatForever(autoreverses: true),
                                value: isRotated
                            )
                    }
            }
            .compositingGroup()

            Image(systemName: "flashlight.on.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .rotationEffect(Angle.degrees(isRotated ? -30 : 30), anchor: .bottom)
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: isRotated
                )
                .onAppear {
                    self.isRotated = true
                }
                .foregroundColor(.primary)

            HStack {
                Spacer()
                Text(title)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            HStack {
                Spacer()
                Text(title2)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                Spacer()
            }
        }
        .frame(height: 250)
    }
}


