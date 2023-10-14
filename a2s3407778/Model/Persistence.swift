//
//  Persistence.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 26/9/2023.
//
// This file is adapted from lesson 6, Core Data Fundamentals from Kodeko
// https://www.kodeco.com/27468235-core-data-fundamentals/lessons/6

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

    /// This variable is to allow the preview canvas to work while using CoreData. It has not been implemented in this project.
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext

    // Dummy data will go here later

    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()

    /// Creating the Managed Object Model and the Managed Object Context
  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
      
      // Creating the Managed Object Context
    container = NSPersistentContainer(name: "Main")
      
      // Don't why we need this if statement, just following the guide
    if inMemory {
      // swiftlint:disable:next force_unwrapping
      container.persistentStoreDescriptions.first!.url = 
        URL(fileURLWithPath: "/dev/null")
    }
      
      // Completing the creation of the CoreData stack by loading the persistent store
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
      
      // These commands are to help CoreData work asycronously. Not sure of the reason for most of them, following guide
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.viewContext.name = "viewContext"
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
  }
}
