//
//  a1s3407778App.swift
//  a1s3407778
//
//  Created by Charles Blyton on 7/8/2023.
//

import SwiftUI

@main

// Created following Kodeko Guide
 struct a1s3407778App: App {
     
     let persistenceController = PersistenceController.shared
     
     @StateObject var settings = DateObservableObject()
     
     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environmentObject(settings)
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
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
