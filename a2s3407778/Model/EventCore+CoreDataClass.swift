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
        case eventID, date, name, note, order, timePeriod, type
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
        self.type = try container.decode(String.self, forKey: .type)
        self.order = try container.decode(Int16.self, forKey: .order)
        self.timePeriod = try container.decode(String.self, forKey: .timePeriod)
        
        
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventID, forKey: .eventID)
        try container.encode(date, forKey: .date)
        try container.encode(name, forKey: .name)
        try container.encode(note, forKey: .note)
        try container.encode(type, forKey: .type)
        try container.encode(order, forKey: .order)
        try container.encode(timePeriod, forKey: .timePeriod)
        
      }
   }

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
