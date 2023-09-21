//
//  Event.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 21/9/2023.
//

import Foundation
import CoreData

public class Event: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var chocolate: NSSet?
    
}
