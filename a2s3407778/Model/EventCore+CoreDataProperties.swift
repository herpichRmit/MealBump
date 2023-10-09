//
//  EventCore+CoreDataProperties.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 9/10/2023.
//
//

import Foundation
import CoreData


extension EventCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventCore> {
        return NSFetchRequest<EventCore>(entityName: "EventCore")
    }

    @NSManaged public var date: Date?
    @NSManaged public var eventID: UUID?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var order: Int16
    @NSManaged public var timePeriod: String?
    @NSManaged public var type: String?

}

extension EventCore : Identifiable {

}
