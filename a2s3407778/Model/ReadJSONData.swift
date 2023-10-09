//
//  ReadJSONData.swift
//  a1s3407778
//
//  Created by Charles Blyton on 17/8/2023.
//

import Foundation


extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        
        // This is to prevent crashing if there is no file to be found
        guard let url = self.url(forResource: file, withExtension: "json") else {
            fatalError("Could not find \(file) in the project123")
        }
        
        // This is to prevent crashing if there is an error loading the data from the file
        guard let jsonData = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project123")
        }
        
        // Creating a new JSONDecoder
        let decoder = JSONDecoder()
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"

        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        
        // This is to prevent crashing if the data cannot be decoded
        guard let loadedData = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Could not decode \(file) in the project123")
        }
        return loadedData
    }
}
