//
//  Card.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI

struct WeekEventCard: View {
    
    @State var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Text(event.title)
                .font(.system(size: 13).weight(.semibold))
            Text(event.timeLabel)
                .font(.system(size: 11))
            if event.type == TypeEnum.shoppingTrip {
                Image(systemName: "cart")
                    .font(.system(size: 11))
            }
            
        }
        .frame(width: 100, height: 100, alignment: .topLeading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.white)
        )
        .shadow(color: Color.black.opacity(0.07), radius: 15, x: 4, y: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 2)
        )
        
        
        
    }
}


