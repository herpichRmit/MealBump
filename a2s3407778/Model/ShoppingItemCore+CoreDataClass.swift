//
//  ShoppingItemCore+CoreDataClass.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 10/10/2023.
//
//

import Foundation
import CoreData


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
           
         var container = try decoder.container(keyedBy: CodingKeys.self)
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
