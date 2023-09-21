//
//  DataControllerCoreData.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 21/9/2023.
//

import CoreData
import Foundation

// Code in this data controller adapted from Paul Hudson's Example (Bookworm SwiftUI Tutorial 3/10)

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Main")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}
