//
//  a1s3407778App.swift
//  a1s3407778
//
//  Created by Charles Blyton on 7/8/2023.
//

import SwiftUI


/// Main App Starting Point
@main
struct a2s3407778App: App {
     
     // Initialising the objects which will be inserted into the App's environment
     let persistenceController = PersistenceController.shared
     @ObservedObject var settings = DateObservableObject()
     
     var body: some Scene {
         WindowGroup {
             
             ContentView()
             // Inserting the CoreData and Environment Object into the Environment
                 .environmentObject(settings)
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
                 .environment(\.timeZone, TimeZone(secondsFromGMT: 3600)!)
         }
     }
 }


// Created following Paul Hudson's Guide
/*
struct a1s3407778App: App {
    @StateObject private var dataController = DataController() //Creating state object of all CoreData Saved Data
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
*/
