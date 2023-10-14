//
//  DataControllerCoreData.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 21/9/2023.
//

// Code in this data controller adapted from Paul Hudson's Example (Bookworm SwiftUI Tutorial 3/10)
// https://www.youtube.com/watch?v=bvm3ZLmwOdU&t=776s

/// This file has been replaced by Persistence.swift

//
//import CoreData
//import Foundation
//
///// This Class creates an object of the data model from the from the xcmodeld file, and then loads the persistent store into memory within the init()
//class DataController: ObservableObject {
//    let container = NSPersistentContainer(name: "Main")
//    
//    init() {
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("CoreData failed to load: \(error.localizedDescription)")
//            }
//        }
//    }
//}
