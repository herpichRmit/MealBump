//
//  EventCore+CoreDataClass.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 2/10/2023.
//
//

import Foundation
import CoreData

@objc(EventCore)
public class EventCore: NSManagedObject, Codable {
    
    enum CodingKeys: CodingKey {
        case eventID, date, name, note, order, mealKind, eventType, archived
     }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventID = try container.decode(UUID.self, forKey: .eventID)
        self.date = try container.decode(Date.self, forKey: .date)
        self.name = try container.decode(String.self, forKey: .name)
        self.note = try container.decode(String.self, forKey: .note)
        self.eventType = try container.decode(String.self, forKey: .eventType)
        self.order = try container.decode(Int16.self, forKey: .order)
        self.mealKind = try container.decode(String.self, forKey: .mealKind)
        self.archived = try container.decode(Bool.self, forKey: .archived)
        
        
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventID, forKey: .eventID)
        try container.encode(date, forKey: .date)
        try container.encode(name, forKey: .name)
        try container.encode(note, forKey: .note)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(order, forKey: .order)
        try container.encode(mealKind, forKey: .mealKind)
        try container.encode(archived, forKey: .archived)
        
      }
   }

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
