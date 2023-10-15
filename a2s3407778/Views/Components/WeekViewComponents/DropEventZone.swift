//
//  DropEventZone.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 14/10/2023.
//

import SwiftUI

// MARK: reference https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-marching-ants-border-effect

/// Card used as placeholder value when user is deciding which day to move a selected card into.
struct DropEventZone: View {
    @State private var phase = 0.0
    
    var body: some View {
        Text("+")
            .font(.system(size: 25).weight(.semibold))
            .frame(width: 100, height: 80, alignment: .center)
            .foregroundColor(.green)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 14)
            .foregroundColor(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                //.strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase))
                .stroke(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase)).foregroundColor(.green)
                .opacity(0.5)
                .onAppear {
                    withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        phase -= 30
                    }
                }
        )
    }
}

