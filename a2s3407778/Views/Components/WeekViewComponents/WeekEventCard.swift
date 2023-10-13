//
//  Card.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//  Made to conform to transferrable by following Sean Allen's Guide at - https://www.youtube.com/watch?v=lsXqJKm4l-U

import SwiftUI
import UniformTypeIdentifiers

struct WeekEventCard: View, Codable, Transferable, Identifiable, Equatable, Hashable {
    
    
    static var transferRepresentation: some TransferRepresentation{ //Required to conform to transferrable protocol
        CodableRepresentation(contentType: .weekEventCard)
    }
    
    var id = UUID()
    let title: String
    let mealKind: String
    let type: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Text(title)
                .font(.system(size: 13).weight(.semibold))
            Text(mealKind)
                .font(.system(size: 11))
            if type == "shoppingTrip" {
                Image(systemName: "cart")
                    .font(.system(size: 11))
            }
            
        }
        .frame(width: 100, height: 80, alignment: .topLeading)
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


extension UTType { // Required to make WeekEventCard conform to transferrable protocal for Drag and Drop Ability
    static let weekEventCard = UTType(exportedAs: "com.charlieblyton.a2s3407778.WeekEventCard")
}
