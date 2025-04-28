//
//  Shapes.swift
//  Weather_SwiftUI
//
//  Created by name on 27/04/2025.
//

import SwiftUI

struct ShapeView: View {
    var body: some View {
        Arc()
            .fill(Color.tabBarBackground)
            .frame(height: 88)
            .overlay(content: {
                Arc()
                    .stroke(Color.tabBarBorder, lineWidth: 0.5)
            })
            .overlay(alignment: .bottom) {
                RoundedShape()
                    .fill(Color.background)
                    .frame(width: 300, height: 100)
                    .overlay(content: {
                        RoundedShape()
                            .stroke(Color.tabBarBorder, lineWidth: 0.5)
                    })
            }
        
    }
    
}

#Preview {
    ShapeView()
}

struct Arc: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // start from 0 and 0
        path.move(to: CGPoint(x: rect.minX-1, y: rect.minY))
        
        // add a cureve with end of max of x and 0 with the point of center in the screen middle
        path.addQuadCurve(to: CGPoint(x: rect.maxX+1, y: rect.minY), control: CGPoint(x: rect.midX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.maxX+1, y: rect.maxY+1))
        path.addLine(to: CGPoint(x: rect.minX-1, y: rect.maxY+1))
        
        path.closeSubpath()
        
        return path
    }
}

struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let (w, h) = (rect.width, rect.height)

        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            .init(x: x * w, y: y * h + 1) // <-- added +1 to y
        }

        // Outer shape
        path.move(to: p(0.42105, 0))
        path.addLine(to: p(0.57895, 0))
        path.addCurve(to: p(0.77343, 0.48699), control1: p(0.69925, 0), control2: p(0.73497, 0.2414))
        path.addCurve(to: p(0.98496, 1), control1: p(0.81325, 0.74125), control2: p(0.85338, 1))
        path.addLine(to: p(0.01504, 1))
        path.addCurve(to: p(0.22657, 0.48699), control1: p(0.14662, 1), control2: p(0.18675, 0.74125))
        path.addCurve(to: p(0.42105, 0), control1: p(0.26503, 0.2414), control2: p(0.30075, 0))
        path.closeSubpath()

        // Inner shape
        path.move(to: p(0.42105, 0.0025))
        path.addLine(to: p(0.57895, 0.0025))
        path.addCurve(to: p(0.70616, 0.15301), control1: p(0.63881, 0.0025), control2: p(0.67755, 0.0625))
        path.addCurve(to: p(0.76536, 0.44198), control1: p(0.73124, 0.23236), control2: p(0.74853, 0.33518))
        path.addLine(to: p(0.77256, 0.48795))
        path.addCurve(to: p(0.84408, 0.84048), control1: p(0.79246, 0.61499), control2: p(0.8125, 0.74365))
        path.addCurve(to: p(0.95458, 0.9975), control1: p(0.87058, 0.92175), control2: p(0.90519, 0.98056))
        path.addLine(to: p(0.04542, 0.9975))
        path.addCurve(to: p(0.15592, 0.84048), control1: p(0.09481, 0.98056), control2: p(0.12942, 0.92175))
        path.addCurve(to: p(0.21995, 0.5356), control1: p(0.18355, 0.75575), control2: p(0.20235, 0.64665))
        path.addLine(to: p(0.22744, 0.48795))
        path.addCurve(to: p(0.29384, 0.15301), control1: p(0.24669, 0.36504), control2: p(0.26518, 0.2437))
        path.addCurve(to: p(0.42105, 0.0025), control1: p(0.32245, 0.0625), control2: p(0.36119, 0.0025))
        path.closeSubpath()

        return path


    }
}
