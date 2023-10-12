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
    //let date : Date = // Date for current array
    @State private var name : String = ""
    @State private var mealKind : String = ""
    @State private var note : String = ""
    //@Binding var servings : Int?
    
    // foods that are a part of current meal
    //@Binding var foodItems : [[String]]
    
    // list of all foodItems the user has used
    //@Binding var allFoodItems : [[String]]
    
    var body: some View {
        NavigationStack(){
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                    TextField("Time period", text: $mealKind)
                    TextField("Note", text: $note)
                }
                
                // Date and serving pickers ommitted until full functionality is implemented
                Section(){
                    Text("Date and serving pickers")
                    //                DatePicker("Date", selection: $date, displayedComponents: [.date])
                    //                    .datePickerStyle(.compact)
                    //                Picker("Servings", selection: $servings ?? 1){
                    //                    Text("1") // TODO: fix picker
                    //                    Text("2")
                    //                    Text("3")
                    //
                    //                }
                }
                
                Section(){
                    // list all food items here
                    
                    // tap food view
    
                    // allows user to add a food they have used before
                    NavigationLink(destination: SearchFoodView()) {
                        Button("Add food from previous meal", action: { print() })
                    }
                    
                    // allows user to add a new food to the meal
                    NavigationLink(destination: NewFoodView()) {
                        Button("Add new food", action: { print() })
                    }
    
                    
                
                }
                
            }
            .navigationTitle("Create meal")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Back", action: { settings.showCreateMealSheet.toggle() } ))
            .navigationBarItems(trailing: Button("Done", action: {
                // when done is press append event to dayInfo

                //var newEvent = EventCore
                /*
                dayInfo.append(Event(id: Int.random(in:50..<4000), title: name ?? "", desc: note ?? "", date: dayInfo[0].date, order: 100, eventType: TypeEnum.meal, timeLabel: mealKind ?? "", foodItems: newFoodItems))
                // when done is press append event to dayInfo
                dayInfo.append(Event(id: Int.random(in:50..<4000), title: name ?? "", desc: note ?? "", date: dayInfo[0].date, order: 100, eventType: TypeEnum.meal, timeLabel: mealKind ?? "", foodItems: newFoodItems))
                 */
                // when done is press append event to events
    //                            addNewEvent(date: currDate, name: name ?? "", note: note ?? "", order: 100, mealKind: mealKind ?? "", eventType: "Meal")

                saveItem()
                settings.showCreateMealSheet = false
            }))
            
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
        newEvent.eventType = "Meal"
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
}

