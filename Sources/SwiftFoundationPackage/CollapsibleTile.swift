//
//  CollapsibleTile.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 2/18/25.
//

import SwiftUI

public struct CollapsibleTile<Content: View>: View {
    let content: () -> Content
    var title: Text
    var isExpanded: Binding<Bool>
    @State var rotation = 0.0

    public init(title: Text, isExpanded: Binding<Bool> ,@ViewBuilder content: @escaping () -> Content) {
        self.isExpanded = isExpanded
        self.content = content
        self.title = title
    }

    public var body: some View {
        VStack {
            HStack {
                title
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                
                Button(action:{
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)){
                        if(isExpanded.wrappedValue){
                            rotation = -90.0
                            isExpanded.wrappedValue = false
                        }
                        else
                        {
                            rotation = 0.0
                            isExpanded.wrappedValue = true
                        }
                    }
                }, label: {
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(rotation))
                } )
                
            }
            if(isExpanded.wrappedValue){
                HStack{
                    content()
                    Spacer()
                }
                .padding(.top)
            }
                
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 13.0).fill(Color(.secondarySystemFill)))
    }
}

//#Preview {
//    CollapsibleTile(title: Text("This is the title").font(.largeTitle),  isExpanded: .constant(true)) { Text("Hello It's Mike") }
//}
