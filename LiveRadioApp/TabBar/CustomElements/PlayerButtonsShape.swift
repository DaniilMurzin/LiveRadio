//
//  PlayerButtonsShape.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 19.09.2024.
//

import SwiftUI

struct PlayerButtonsShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.36666*width, y: 0.0376*height))
        path.addCurve(to: CGPoint(x: 0.62307*width, y: 0.0376*height),
                      control1: CGPoint(x: 0.44599*width, y: -0.00493*height), control2: CGPoint(x: 0.54374*width, y: -0.00493*height))
        path.addLine(to: CGPoint(x: 0.86074*width, y: 0.16502*height))
        path.addCurve(to: CGPoint(x: 0.98894*width, y: 0.37121*height), control1: CGPoint(x: 0.94007*width, y: 0.20755*height), control2: CGPoint(x: 0.98894*width, y: 0.28615*height))
        path.addLine(to: CGPoint(x: 0.98894*width, y: 0.62605*height))
        path.addCurve(to: CGPoint(x: 0.86074*width, y: 0.83224*height), control1: CGPoint(x: 0.98894*width, y: 0.71111*height), control2: CGPoint(x: 0.94007*width, y: 0.78971*height))
        path.addLine(to: CGPoint(x: 0.62307*width, y: 0.95966*height))
        path.addCurve(to: CGPoint(x: 0.36666*width, y: 0.95966*height), control1: CGPoint(x: 0.54374*width, y: 1.00219*height), control2: CGPoint(x: 0.44599*width, y: 1.00219*height))
        path.addLine(to: CGPoint(x: 0.12899*width, y: 0.83224*height))
        path.addCurve(to: CGPoint(x: 0.00079*width, y: 0.62605*height), control1: CGPoint(x: 0.04966*width, y: 0.78971*height), control2: CGPoint(x: 0.00079*width, y: 0.71111*height))
        path.addLine(to: CGPoint(x: 0.00079*width, y: 0.37121*height))
        path.addCurve(to: CGPoint(x: 0.12899*width, y: 0.16502*height), control1: CGPoint(x: 0.00079*width, y: 0.28615*height), control2: CGPoint(x: 0.04966*width, y: 0.20755*height))
        path.addLine(to: CGPoint(x: 0.36666*width, y: 0.0376*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    PlayerButtonsShape()
}
