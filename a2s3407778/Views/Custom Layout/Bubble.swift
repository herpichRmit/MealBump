//
//  Bubble.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 27/8/2023.
//

import SwiftUI

/// View for the circular buttons within the CustomMenu
struct Bubble: View {
    let colour: Color
    let borderColor = Color.gray
    let text: String
    let active: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.white, lineWidth: 3)
                .background(Circle().fill(colour))
                .frame(width: active ? 70 : 0, height: active ? 70 : 0)
            Image(systemName: text)
                .imageScale(.large)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(width: 70, height: 70)
                .foregroundStyle(.black)
                .font(Font.custom("SF Pro", size: active ? 12 : 1))
                .opacity(active ? 1 : 0)
        }
    }
}

