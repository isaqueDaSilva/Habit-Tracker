//
//  ProgressBar.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 04/08/23.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .fill(.black.opacity(0.2))
                .foregroundColor(.gray)
            
            withAnimation {
                Circle()
                    .trim(from: 0, to: CGFloat(min(self.progress, 1)))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270))
            }
        }
    }
}

