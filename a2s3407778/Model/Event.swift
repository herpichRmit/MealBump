//
//  Event.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 27/8/2023.
//

import Foundation

struct Event: Codable, Hashable, Identifiable {
    let id: Int
    let title, desc: String
    let date: Date
    let order: Int
    let type: TypeEnum
    let timeLabel : String
    var foodItems : [[String]]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(date)
    }
    
    static let allEvents: [Event] = Bundle.main.decode(file: "TestData")
    static let samplePerson: Event = allEvents[0]
}

enum TypeEnum: String, Codable {
    case meal = "meal"
    case shoppingTrip = "shoppingtrip"
    case skippedMeal = "skippedmeal"
}
