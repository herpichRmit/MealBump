//
//  EventTile.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 21/9/2023.
//

import SwiftUI

/// View is used in DayFilteredList.Swift. View is a card of a particular event to be displayed in a list within DayView.swift
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
        .background(/*changeBackgrndColour(type: eventType)*/Color.white.shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2))
        .border(.gray)
    }
    
}

///Function for changing the background color of events to more clearly visually seperate different types. Currently unused in deployed code.
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
