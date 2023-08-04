//
//  Arc.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 04/08/23.
//

import SwiftUI

struct Arc: InsettableShape {
    var insertAmount: CGFloat = 0
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle(degrees: 90)
        let startAngleModifier = startAngle - rotationAdjustment
        let endAngleModifier = endAngle - rotationAdjustment
        
        return Path { path in
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2 - insertAmount,
                startAngle: startAngleModifier,
                endAngle: endAngleModifier,
                clockwise: !clockwise
            )
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insertAmount += amount
        return arc
    }
}

