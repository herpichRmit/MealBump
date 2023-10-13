//
//  CreateMealSheet.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI

struct NewMealSheet: View {
    
    @Environment(\.dismiss) var dismiss //a dismiss variable to be used inside a button later
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    //@FetchRequest var events: FetchedResults<EventCore> //New Request to initialize in init()
    
    @EnvironmentObject var settings: DateObservableObject // Object to access custom environment variable
    
    // bindings for values required to create a new meal
    @State private var name : String = ""
    @State private var mealKind : String = ""
    @State private var note : String = ""
    @State private var date : Date = Date()

    @State private var items : [ShoppingItemCore] = []
    @State private var itemToRemove : ShoppingItemCore?
    
    
    var body: some View {
        NavigationStack(){
            
            Form {
                // Text fields
                Section(){
                    TextField("Name", text: $name)
                    TextField("Time period", text: $mealKind)
                    TextField("Note", text: $note)
                }
                
                // Date picker
                Section(){
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                }
                
                // List food in meal
                List {
                    if items != [] {
                        ForEach(settings.selectedEvent.itemArray, id: \.self) { item in
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
                items = settings.selectedEvent.itemArray
                
                // Use current selected meal, else use default values
                name = settings.selectedEvent.name ?? ""
                mealKind = settings.selectedEvent.mealKind ?? ""
                note = settings.selectedEvent.note ?? ""
                date = settings.selectedEvent.date ?? settings.selectedDate
            }
        }
    }
    
    
    func deleteItem(at offsets: IndexSet) {
        // get item that is being removed
        offsets.forEach { (i) in
            itemToRemove = settings.selectedEvent.itemArray[i]
        }
        settings.selectedEvent.removeFromShoppingItemCore(itemToRemove!)

        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }

    }
    
    func saveItem() {
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        newEvent.date = settings.selectedDate //Add events to the selected date
        newEvent.name = name
        newEvent.note = note
        newEvent.order = Int16(100)
        newEvent.mealKind = mealKind
        newEvent.eventType = EventType.Meal.rawValue //Use the enum to ensure consistant values
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteEvent() {
        viewContext.delete(settings.selectedEvent)
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func newEvent() {
        // Adding data to new EventCore Object
        settings.selectedEvent.date = settings.selectedDate //Add events to the selected date
        settings.selectedEvent.name = name
        settings.selectedEvent.note = note
        settings.selectedEvent.order = Int16(100)
        settings.selectedEvent.mealKind = mealKind
        settings.selectedEvent.type = "Meal"
    
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
}

