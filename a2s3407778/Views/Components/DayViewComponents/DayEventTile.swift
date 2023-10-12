//
//  EventTile.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 21/9/2023.
//

import SwiftUI

struct DayEventTile: View {
    
    var title: String
    var note: String?
    var eventType: String?
    var icon: String?
    var mealKind: String?
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading) {
                
                if let icon = icon {
                    Text("\(title)  \(Image(systemName: icon))")
                        .font(.system(.headline))
                } else {
                    Text(title)
                        .font(.system(.headline))
                }
                
                if let note = note {
                    Spacer()
                    
                    Text(note)
                        .font(.footnote)
                    Spacer()
                    
                }
                
                if let mealKind = mealKind {
                    Text(mealKind)
                        .font(.bold(.subheadline)())
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            
            Spacer()
            
            VStack{
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .padding(20)
                Spacer()
            }
        }
        .background(changeBackgrndColour(type: eventType).shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2))
        .border(.gray)
    }
    
}

func changeBackgrndColour(type: String?) -> Color{
    switch (type) {
    case "Meal":
        return Color.white
    case "ShoppingTrip":
        return Color.yellow
    case "Other":
        return Color.white
    default:
        return Color.white
        
    }
}
