//
//  EventCore+CoreDataClass.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 2/10/2023.
//
// For Refreshed on how this file works check Kodeco - https://www.kodeco.com/27468235-core-data-fundamentals/lessons/11

import Foundation
import CoreData


/// The CoreData Class which represents the Event Entity in the CoreData Model. 'Core' suffix to differenciate between Event Objects used in earlier versions of app
@objc(EventCore)
final public class EventCore: NSManagedObject, NSItemProviderWriting, NSItemProviderReading, Codable {
    
    
    /// For NSItemProviderWriting
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return ["EventCore"]
    }
    
    public func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping @Sendable (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            let json = String(data: data, encoding: String.Encoding.utf8)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    
    /// For NSItemProviderReading
    public static var readableTypeIdentifiersForItemProvider: [String] {
        return ["EventCore"]
    }
    
    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> EventCore {
        let decoder = JSONDecoder()
        do {
            let myJSON = try decoder.decode(EventCore.self, from: data)
            return myJSON // may give errors
        } catch {
            fatalError("Err")
        }
    }
    
    
    /// For Codable extension
    enum CodingKeys: CodingKey {
        case eventID, date, name, note, order, mealKind, eventType, archived, timePeriod, type, shoppingItemCore
     }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(entity: NSEntityDescription.entity(forEntityName: "EventCore", in: context)!, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.eventID = try container.decode(UUID.self, forKey: .eventID)
        self.date = try container.decode(Date.self, forKey: .date)
        self.name = try container.decode(String.self, forKey: .name)
        self.note = try container.decode(String.self, forKey: .note)
        self.eventType = try container.decode(String.self, forKey: .eventType)
        self.order = try container.decode(Int16.self, forKey: .order)
        self.mealKind = try container.decode(String.self, forKey: .mealKind)
        self.archived = try container.decode(Bool.self, forKey: .archived)
        self.timePeriod = try container.decode(String.self, forKey: .timePeriod) // new
        self.type = try container.decode(String.self, forKey: .type) // new
        self.shoppingItemCore = try container.decode(Set<ShoppingItemCore>.self, forKey: .shoppingItemCore) as NSSet // new, do i need?
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
        try container.encode(timePeriod, forKey: .timePeriod)
        try container.encode(type, forKey: .type)
        if let shoppingItems = shoppingItemCore {
            try container.encode(shoppingItemCore?.allObjects as! [ShoppingItemCore], forKey: .shoppingItemCore)
        }
    }
}

/// Used to for readibility in `required convenience public init`
enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
