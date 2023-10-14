//
//  CreateMealSheet.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI

/// NewMealSheet is a form for users to create a new meal. They will be able to set ``EventCore`` properties including `name`, `mealKind`, `note`, `date` and related `ShoppingItemCore`.
struct NewMealSheet: View {
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData
    @EnvironmentObject var settings: DateObservableObject // For accessing global variables
    @Environment(\.dismiss) var dismiss // to close the view
    
    // Default values for form.
    @State private var name : String = ""
    @State private var mealKind : String = ""
    @State private var note : String = ""
    @State private var date : Date = Date()

    @State private var items : [ShoppingItemCore] = []
    @State private var itemToRemove : ShoppingItemCore?
    
    
    var body: some View {
        NavigationStack(){
            
            Form {
                // Text fields.
                Section(){
                    TextField("Name", text: $name)
                    TextField("Time period", text: $mealKind)
                    TextField("Note", text: $note)
                }
                
                // Date picker.
                Section(){
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                }
                
                // List all food items that have been added to a meal
                List {
                    if items != [] {
                        ForEach((settings.selectedEvent?.itemArray)!, id: \.self) { item in
                            NavigationLink(destination: EditFoodView(item: item)) {
                                Text(item.wrappedName)
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    // allows user to search for a food
                    NavigationLink(destination: SearchFoodView()) {
                        Text("Add food").foregroundColor(.blue)
                    } // -> add food to selectedEvent
                }
                
            }
            .navigationTitle("Create meal")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Back", action: {
                
                settings.selectedEvent = EventCore()
                settings.showCreateMealSheet.toggle()
            }))
            .navigationBarItems(trailing: Button("Done", action: {
                saveItem()
                settings.showCreateMealSheet = false
            }))
            .onAppear(){
                items = settings.selectedEvent?.itemArray ?? []
                
                // Use current selected meal, else use default values
                name = settings.selectedEvent?.name ?? ""
                mealKind = settings.selectedEvent?.mealKind ?? ""
                note = settings.selectedEvent?.note ?? ""
                date = settings.selectedEvent?.date ?? settings.selectedDate
            }
        }
    }
    
    
    /// Takes an IndexSet and removes respective ``ShoppingItemCore`` as a child of the ``EventCore`` object within CoreData storage.
    /// - Parameter offsets: An IndexSet from a forEach loop
    func deleteItem(at offsets: IndexSet) {
        // get item that is being removed
        offsets.forEach { (i) in
            itemToRemove = settings.selectedEvent?.itemArray[i]
        }
        settings.selectedEvent?.removeFromShoppingItemCore(itemToRemove!)

        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }

    }
    
    /// Instatiates a new EventCore object and assigns user input to properties.
    func saveItem() {
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext)
        newEvent.date = settings.selectedDate
        newEvent.name = name
        newEvent.note = note
        newEvent.order = Int16(100)
        newEvent.mealKind = mealKind
        newEvent.eventType = EventType.Meal.rawValue // Use the enum to ensure consistent values.
        
        // Saving data
        saveData()
    }
    
    /// Removes EventCore stored in global variable `selectedEvent` from ``EventCore`` CoreData storage.
    func deleteEvent() {
        viewContext.delete(settings.selectedEvent!)
        
        // Saving data
        saveData()
    }
    
    /// Helper function to save data to ``EventCore``
    func saveData() {
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
}

