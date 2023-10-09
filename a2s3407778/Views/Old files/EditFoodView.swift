//
//  EditFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//


/*
 
 Each food will have these properties
 
 name : string from TextField
 amount : string from TextField
 category : string from Picker
 locaction : string from Picker
 
 This view will then add all details to an array
 
 ["item","measure","category","location"]
 
 Then it will append it to the binding foodItems
 
 foodItems = [
    ["item","measure","category","location"]
 ]
 
 
 */


import SwiftUI

struct EditFoodView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name : String?
    @State var note : String?
    @State var category : String?
    @State var location : String?
    let types = ["None","Dairy", "Fruit", "Vegetables", "Meat", "Bakery", "Other"]
    let locations = ["None","Woolworths", "Coles", "IGA", "Butcher"]
    
    @State var currentItem: [String]
    @Binding var foodItems: [[String]]
    
    //@Binding var viewPath : NavigationPath
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    TextField("Name", text: $name ?? "")
                    TextField("Amount", text: $note ?? "")
                }
                Section(){
                    Picker("Category", selection: $category ?? ""){
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Location", selection: $location ?? ""){
                        ForEach(locations, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
            }
            .onAppear {
                self.useExistingItem()
            }
            .navigationTitle("Edit food")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save", action: {
                updateExisting()
                dismiss()
            }))
            
        }
    }
    
    func useExistingItem() {
        let temp = currentItem
        
        name = temp[0]
        note = temp[1]
        category = temp[2]
        location = temp[3]
    }
    
    func updateExisting() {
        
        // find position of current item in foodItems
        // update at that position
        
        print("testA")
        
        print(foodItems.firstIndex(of: currentItem))
        
        if let currentItemArrPos = foodItems.firstIndex(of: currentItem) {
            print(currentItemArrPos)
            foodItems[currentItemArrPos][0] = name ?? "Food"
            foodItems[currentItemArrPos][1] = note ?? ""
            foodItems[currentItemArrPos][2] = category ?? "None"
            foodItems[currentItemArrPos][3] = location ?? "None"
            
            print(foodItems[currentItemArrPos])
            print("tes")
        } else {
            foodItems.append([name ?? "Food", note ?? "", category ?? "None", location ?? "None"])
        }
        
        
        
    }
    
}
