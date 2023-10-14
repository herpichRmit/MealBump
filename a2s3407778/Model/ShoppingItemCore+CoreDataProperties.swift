//
//  ShoppingItemCore+CoreDataProperties.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 10/10/2023.
//
// For Refreshed on how this file works check Kodeco - https://www.kodeco.com/27468235-core-data-fundamentals/lessons/11


import Foundation
import CoreData


extension ShoppingItemCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItemCore> {
        return NSFetchRequest<ShoppingItemCore>(entityName: "ShoppingItemCore")
    }

    @NSManaged public var category: String?
    @NSManaged public var checked: Bool
    @NSManaged public var itemID: UUID?
    @NSManaged public var measure: String?
    @NSManaged public var name: String?
    @NSManaged public var eventCore: EventCore?

    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    
}

extension ShoppingItemCore : Identifiable {

}
