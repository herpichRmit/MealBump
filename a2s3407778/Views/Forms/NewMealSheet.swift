//
//  CreateMealSheet.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI

struct NewMealSheet: View {
    
    // bindings for values required to create a new meal
    //let date : Date = // Date for current array
    @Binding var name : String?
    @Binding var timePeriod : String?
    @Binding var note : String?
    //@Binding var servings : Int?
    
    // foods that are a part of current meal
    //@Binding var foodItems : [[String]]
    
    // list of all foodItems the user has used
    //@Binding var allFoodItems : [[String]]
    
    var body: some View {
        Form {
            
            Section(){
                TextField("Name", text: $name ?? "")
                TextField("Time period", text: $timePeriod ?? "")
                TextField("Note", text: $note ?? "")
            }
            
            // Date and serving pickers ommitted until full functionality is implemented
            Section(){
//                DatePicker("Date", selection: $date, displayedComponents: [.date])
//                    .datePickerStyle(.compact)
//                Picker("Servings", selection: $servings ?? 1){
//                    Text("1") // TODO: fix picker
//                    Text("2")
//                    Text("3")
//                    
//                }
            }
            
//            Section(){
//                if foodItems != [[]] {
//
//                    // iterates through all foodItems in the meal and displays them as links
//                    // allows user to edit the details of each food component
//                    ForEach(foodItems, id: \.self) { item in
//                        if item != [] {
//                            NavigationLink(destination: EditFoodView(currentItem: item, foodItems: $foodItems)) {
//                                Text(item[0])
//                            }
//                        }
//                    }
//                }
//
//                // allows user to add a food they have used before
//                NavigationLink(destination: SearchFoodView(foodItems: $foodItems, allFoodItems: $allFoodItems)) { // showNestedView: $showNestedView,  isActive: $showNestedView
//                    Button("Add food from previous meal", action: { print() }) //showNestedView = true; print(showNestedView)
//                }
//
//                // allows user to add a new food to the meal
//                NavigationLink(destination: NewFoodView(foodItems: $foodItems)) {
//                    Button("Add new food", action: { print() })
//                }
                
            //}
            
        }
        
    }
}

