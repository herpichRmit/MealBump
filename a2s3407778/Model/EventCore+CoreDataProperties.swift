//
//  EventCore+CoreDataProperties.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 10/10/2023.
//
//

import Foundation
import CoreData
import SwiftUI
import UniformTypeIdentifiers

extension EventCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventCore> {
        return NSFetchRequest<EventCore>(entityName: "EventCore")
    }

    @NSManaged public var date: Date?
    @NSManaged public var eventID: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var order: Int16
    @NSManaged public var mealKind: String?
    @NSManaged public var eventType: String?
    @NSManaged public var archived: Bool
    @NSManaged public var timePeriod: String?
    @NSManaged public var type: String?
    @NSManaged public var shoppingItemCore: NSSet?
    
    
    // Trying to convert from NSSet to Set
    public var itemArray: [ShoppingItemCore] {
        let set = shoppingItemCore as? Set<ShoppingItemCore> ?? []
        
        // Returning all items that make up this meal
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    

}

// MARK: Generated accessors for shoppingItemCore
extension EventCore {

    @objc(addShoppingItemCoreObject:)
    @NSManaged public func addToShoppingItemCore(_ value: ShoppingItemCore)

    @objc(removeShoppingItemCoreObject:)
    @NSManaged public func removeFromShoppingItemCore(_ value: ShoppingItemCore)

    @objc(addShoppingItemCore:)
    @NSManaged public func addToShoppingItemCore(_ values: NSSet)

    @objc(removeShoppingItemCore:)
    @NSManaged public func removeFromShoppingItemCore(_ values: NSSet)

}

extension EventCore : Identifiable {

}

extension UTType {
    static let event = UTType(exportedAs: "com.charlieblyton.a2s3407778.event")

}

extension EventCore : Transferable {
    static public var transferRepresentation: some TransferRepresentation{
        CodableRepresentation(contentType: .event)
    }
}

extension CodingUserInfoKey {

  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!

}
