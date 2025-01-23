//
//  SmallRingControl.swift
//  MobileGoRecruit
//
//  Created by Michael Kacos on 1/22/25.
//

import SwiftUI


public struct SmallRingControl: View {
    var goal: CGFloat
    var actual: CGFloat
    var color: Color = .white
    var centerNumber: Int? = nil
    var centerTitle: String? = nil
    @State var gradient = Gradient(colors: [.white.opacity(0.4), .white])
    @State var backgroundGradient = Gradient(colors: [.white.opacity(0.4), .white])
    @State var progress: CGFloat = 0.9
    @State var isLarge: Bool = false
    
    public init(goal: CGFloat, actual: CGFloat, color: Color, centerNumber: Int? = nil, centerTitle: String? = nil) {
        self.goal = goal
        self.actual = actual
        self.color = color
        self.centerNumber = centerNumber
        self.centerTitle = centerTitle
       
    }

    public var body: some View {
       
            
            
            ZStack {
                Circle()
                
                    .stroke(
                        AngularGradient(
                            gradient: backgroundGradient,
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: isLarge ? 30 : 10, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                Circle()
                    .trim(from: 0, to: progress)
                    .rotation(.degrees(-90))
                    .stroke(
                        AngularGradient(
                            gradient: gradient,
                            center: .center,
                            startAngle: .degrees(-90),
                            endAngle: .degrees(Double(progress) * Double(360) - Double(90))
                        ),
                        style: StrokeStyle(lineWidth: isLarge ? 30 : 10, lineCap: .round)
                    )
                    .overlay(
                        GeometryReader { geo in
                            // End round line cap
                            Circle()
                                .fill(self.gradient.stops[1].color)
                                .frame(width: isLarge ? 30 : 10, height: isLarge ? 30 : 10)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                .offset(x: min(geo.size.width, geo.size.height) / 2)
                                .rotationEffect(.degrees(Double(progress) * Double(360) - Double(90)))
                                .shadow(color: .black, radius: 4, x: 0, y: 0)
                        }
                            .clipShape(
                                // Clip end round line cap and shadow to front
                                Circle()
                                    .rotation(.degrees(Double(-90) + Double(progress) * Double(360) - Double(0.5)))
                                    .trim(from: 0, to: 0.25)
                                    .stroke(style: .init(lineWidth: isLarge ? 30 : 10))
                            )
                    )
                if(isLarge){
                    if let number = centerNumber {
                        VStack{
                            Text(number.description)
                                .font(.largeTitle)
                            if(centerTitle != nil) {
                                Text(centerTitle.displayOptionalText)
                                    .font(.footnote)
                            }
                        }
                    }
                    
                }
                
            }
            
            .frame(width: isLarge ? 120 : 40, height: isLarge ? 120 : 40)
            .task {
                updateNumbers()
                if(actual == 0){
                    self.gradient = Gradient(colors: [.red.opacity(0.2), .red])
                }
                else {
                    self.gradient = Gradient(colors: [color.opacity(0.2), color])
                }
                if(actual == 0){
                    self.backgroundGradient = Gradient(colors: [.red.opacity(0.2)])
                }
                else{
                    self.backgroundGradient = Gradient(colors: [color.opacity(0.2)])
                }
            }
            .onTapGesture {
                
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatCount(1, autoreverses: true)) {
                    isLarge = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatCount(1, autoreverses: true)) {
                        isLarge = false
                    }
                }
            }
        
        
    }

    public func updateNumbers() {
        
        progress = CGFloat(actual) / CGFloat(goal)
    }
    
}

#Preview {
    SmallRingControl(goal: 30, actual: 21, color: .red, centerNumber: 115, centerTitle: "Contacted")
}
