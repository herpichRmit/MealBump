//
//  NewFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 20/8/2023.
//


import SwiftUI

struct NewFoodView: View {
    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) var dismiss
    
    @State var name : String = ""
    @State var note : String = ""
    @State var category : String = ""
    let types = ["None","Dairy", "Fruit", "Vegetables", "Meat", "Bakery", "Other"]
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                    TextField("Amount", text: $note)
                }
                Section(){
                    Picker("Category", selection: $category){
                        ForEach(ShopItemCategory.allCases, id: \.self) {
                            Text(String(describing:$0))
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
        let newShoppingItem = ShoppingItemCore(context: viewContext)
        newShoppingItem.name = name
        newShoppingItem.measure = note
        newShoppingItem.category = category
        newShoppingItem.checked = false
        
        saveData()
    }
    
    func saveData(){
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    
}

