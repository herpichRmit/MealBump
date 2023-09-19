//
//  Event.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 27/8/2023.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct Event: Codable, Hashable, Identifiable, Transferable {
    let id: Int
    let title, desc: String
    let date: Date
    var order: Int
    let type: TypeEnum
    let timeLabel : String
    var foodItems : [[String]]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(date)
    }
    
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .event)
    }
    
    static let allEvents: [Event] = Bundle.main.decode(file: "TestData")
    static let samplePerson: Event = allEvents[0]
}

extension UTType {
    static let event = UTType(exportedAs: "com.charlieblyton.a2s3407778.event")
}


enum TypeEnum: String, Codable {
    case meal = "meal"
    case shoppingTrip = "shoppingtrip"
    case skippedMeal = "skippedmeal"
}
