//
//  Bubble.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 27/8/2023.
//

import SwiftUI

struct Bubble: View {
    
    let colour: Color
    let borderColor = Color.gray
    let text: String
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.gray, lineWidth: 3)
                .background(Circle().fill(colour))
                .frame(width: 70, height: 70)
            Text(text)
                .multilineTextAlignment(.center)
                .frame(width: 70, height: 70)
                .foregroundStyle(.black)
                .font(Font.caption.weight(.semibold))
        }
    }
}

