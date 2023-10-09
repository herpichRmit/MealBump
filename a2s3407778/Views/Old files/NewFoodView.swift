//
//  NewFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 20/8/2023.
//


import SwiftUI

struct NewFoodView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name : String?
    @State var note : String?
    @State var category : String?
    @State var location : String?
    let types = ["None","Dairy", "Fruit", "Vegetables", "Meat", "Bakery", "Other"]
    let locations = ["None","Woolworths", "Coles", "IGA", "Butcher"]
    
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
    
    
    @Binding var foodItems: [[String]]
    
    
    
    
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

            .navigationTitle("Edit food")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Add", action: {
                addFood()
                dismiss()
            }))
            
        }
    }
    
    func addFood() {
        let currentFood = [name ?? "", note ?? "", category ?? "", location ?? ""]
        
        foodItems.append(currentFood)
        
        print(currentFood)
        print(foodItems)
        
    }
    
    
}

/*
 struct EditFoodView_Previews: PreviewProvider {
 static var previews: some View {
 EditFoodView(foodItems: )
 }
 }
 */
