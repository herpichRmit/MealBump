//
//  SheetView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//


// SheetView contains all the modals and forms to manage meal data

/*
     Can create a meal using the following
     
     name = "meal name"
     note = "meal note"
     timePeriod = "meal time period"
     date = <default to todays date>    // ommitted from milestone 1 demo
     order = <passed in value>          // ommitted from milestone 1 demo
     foodItems = []
     
     need to receive following from searchFoodView
     
     ["item","measure","category","location"]
     
     then append to a list of foodItems
     
     foodItems = [
        ["item","measure","category","location"]
     ]
     
     then be able to add those foodItems to an event object
     
     {
       "id": <generate>,
       "name": "meal name"
       "note": "meal note",
       "date": "2023-18-17", (whatever date format is)
       "order": 3,
       "timePeriod": "meal",
        "foodItems": [ ["item","measure","category","location"], ["item","measure","category","location"]]
     }
 
 */


import SwiftUI

struct SheetView: View {
    
    // Creating a new meal
    @State var name: String?
    @State var note: String?
    @State var timePeriod: String?
    @State var date = Date()
    @State var servings: Int?
    
    // foodItems represents all current items within a meal
    @State var newFoodItems: [[String]] = [[]]
    
    // allFoodItems represents all current items within database
    // example foods are hardcoded for the milestone 1 demo
    @State var allFoodItems: [[String]] = [["Beef 80% lean","250g","Meat","Butcher"], ["Apple","5 or 6","Fruit","Woolworths"], ["Milk","200ml","Dairy","Coles"]] // populate
    
    // used to control which modal is open
    @Binding var events : [Event]
    @Binding var isMenuShown : Bool
    @Binding var showActionSheet : Bool
    @Binding var showCreateMealSheet : Bool
    @Binding var showCreateShopSheet : Bool
    @Binding var showCreateOtherSheet : Bool
    @Binding var showSearchMealSheet : Bool
    
    
    var body: some View {        
        
        // activating this button calls the custom action sheet (using custom layout) in weekPlannerView
        PlusButton( function: { isMenuShown = true })
        
            .sheet(isPresented: $showCreateMealSheet) {
                NavigationStack(){
                    // calls CreateMealSheet that is encapsulated in another file
                    CreateMealSheet(name: $name, timePeriod: $timePeriod, note: $note, servings: $servings, foodItems: $newFoodItems, allFoodItems: $allFoodItems)
                        .navigationTitle("Create meal")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button("Back", action: { showCreateMealSheet.toggle() } ))
                        .navigationBarItems(trailing: Button("Done", action: {
                            // when done is press append event to events
                            events.append(Event(id: Int.random(in:50..<4000), title: name ?? "", desc: note ?? "", date: events[0].date, order: 100, type: TypeEnum.meal, timeLabel: timePeriod ?? "", foodItems: newFoodItems))
                            
                            // clearing values
                            name = nil
                            timePeriod = nil
                            note = nil
                            servings = nil
                            
                            showCreateMealSheet = false
                        }))
                }
            }
            // Ommited from milestone 1 presentation
            .sheet(isPresented: $showSearchMealSheet) {
                Form {
                    Button("Dismiss", action: { showSearchMealSheet.toggle() })
                }
            }
            // Creating a shopping trip event
            .sheet(isPresented: $showCreateShopSheet) {
                NavigationStack(){
                    Form {
                        Section(){
                            TextField("Time period", text: $timePeriod ?? "")
                            TextField("Note", text: $note ?? "")
                        }
                        
                    }
                    .navigationTitle("Create shopping trip")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button("Back", action: { showCreateShopSheet.toggle() } ))
                    .navigationBarItems(trailing: Button("Done", action: {
                        events.append(Event(id: Int.random(in:50..<4000), title: "Shopping trip", desc: note ?? "", date: events[0].date, order: 99, type: TypeEnum.shoppingTrip, timeLabel: timePeriod ?? "", foodItems: newFoodItems))
                        showCreateShopSheet.toggle()
                    }))
                    
                }
            }
            // Ommited from milestone 1 presentation
            .sheet(isPresented: $showCreateOtherSheet) {
                Form {
                    Button("Dismiss", action: { showCreateOtherSheet.toggle() })
                }
            }
    }
}
