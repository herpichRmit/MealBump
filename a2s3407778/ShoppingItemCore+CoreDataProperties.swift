//
//  ShoppingItemCore+CoreDataProperties.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 25/9/2023.
//
//

import Foundation
import CoreData


extension ShoppingItemCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItemCore> {
        return NSFetchRequest<ShoppingItemCore>(entityName: "ShoppingItemCore")
    }

    @NSManaged public var category: String?
    @NSManaged public var itemID: UUID?
    @NSManaged public var measure: String?
    @NSManaged public var name: String?
    @NSManaged public var checked: Bool

}

extension ShoppingItemCore : Identifiable {

}
