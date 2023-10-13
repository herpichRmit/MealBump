////
////  CoreDataHelper.swift
////  a2-s3407778
////
////  Created by Charles Blyton on 12/10/2023.
////
//
//import Foundation
//
//class CoreDataHelper {
//    
//    static let shared = CoreDataHelper()
//    
//    private lazy var mainManagedObjectContext: NSManagedObjectContext = {
//          let appDelegate = UIApplication.shared.delegate as! AppDelegate
//          return appDelegate.persistentContainer.viewContext
//      }()
//    
//    
//    private func save() {
//            if mainManagedObjectContext.hasChanges {
//                do {
//                    try mainManagedObjectContext.save()
//                } catch {
//                    print("Error saving main managed object context: \(error)")
//                }
//            }
//        }
//}
