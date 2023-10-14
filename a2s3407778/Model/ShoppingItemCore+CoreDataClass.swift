//
//  ShoppingItemCore+CoreDataClass.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 10/10/2023.
//
// For Refreshed on how this file works check Kodeco - https://www.kodeco.com/27468235-core-data-fundamentals/lessons/11


import Foundation
import CoreData

/// The CoreData Class which represents the ShoppingItem Entity in the CoreData Model. 'Core' suffix to differenciate between Event Objects used in earlier versions of app
@objc(ShoppingItemCore)
final public class ShoppingItemCore: NSManagedObject {

    
    enum CodingKeys: String, CodingKey {
           case category, checked, itemID, measure, name
        }
    
}

extension ShoppingItemCore: Decodable {
    convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
                throw DecoderConfigurationError.missingManagedObjectContext
         }
        
         self.init(context: context)
           
         let container = try decoder.container(keyedBy: CodingKeys.self)
         let category = try container.decode(String.self, forKey: .category)
         let checked = try container.decode(Bool.self, forKey: .checked)
         let itemID = try container.decode(UUID.self, forKey: .itemID)
         let measure = try container.decode(String.self, forKey: .measure)
         let name = try container.decode(String.self, forKey: .name)
         //movieDetails =  MovieDetail(language: language, genre: genre, releaseDate: releaseDate, bannerImageUrl: bannerUrl)
        }
}


extension ShoppingItemCore : Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category, forKey: .category)
        try container.encode(checked, forKey: .checked)
        try container.encode(itemID, forKey: .itemID)
        try container.encode(measure, forKey: .measure)
        try container.encode(name, forKey: .name)
      }
    
}
