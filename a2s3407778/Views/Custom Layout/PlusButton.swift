//
//  PlusButton.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI

struct PlusButton: View{
    
    var body: some View {
        ZStack(){
            Text("+")
                .foregroundColor(.black)
                .font(.system(size: 24))
                .zIndex(1)
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
                .overlay{
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                        
                }
                .shadow(color: Color.black.opacity(0.04), radius: 15, x: 4, y: 10)
        }
    }
}
