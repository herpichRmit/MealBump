//
//  ShoppingItem.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 27/8/2023.
//

import Foundation

//Codable allows the coding and decoding
// Hashable allows
// Idetifiable allows the ShoppingItem object to be used in lists more easily

struct ShoppingItem: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    var checked: Bool //Because we can switch this on and off in the app
     
    static let allShoppingItems: [ShoppingItem] = Bundle.main.decode(file: "ShoppingItems")
//    static let samplePerson: Event = allEvents[0]
}
