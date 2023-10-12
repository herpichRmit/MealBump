//
//  EditFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//


import SwiftUI

struct EditFoodView: View {
    
    @EnvironmentObject var settings: DateObservableObject
    
    @Environment(\.dismiss) var dismiss
    
    // Fetch Request for ALL Items in the shopping list
    @FetchRequest(sortDescriptors: []) private var allShoppingItems: FetchedResults<ShoppingItemCore>
    
    @State var name : String = ""
    @State var note : String = ""
    @State var category : String = ""
    let types = ["None", "Dairy", "Fruit", "Vegetables", "Meat", "Bakery", "Other"]
    
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                    TextField("Amount", text: $note)
                }
                Section(){
                    //ForEach(allShoppingItems, id: \.self) { item in
                    //    Text(item)
                    //}
                }
                Section(){
                    Picker("Category", selection: $category){
                        ForEach(types, id: \.self) {
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
        /*
         
         Functionality to update the
         
         */
        
    }
    
    func updateExisting() {
        
        let newItem = ShoppingItemCore()
        newItem.name = name
        newItem.category = category
        newItem.measure = note
        newItem.checked = false
        
        settings.selectedEvent.addToShoppingItemCore(newItem)
        
        
    }
    
}
