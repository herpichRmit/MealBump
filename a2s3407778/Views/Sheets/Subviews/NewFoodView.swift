//
//  NewFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 20/8/2023.
//

import SwiftUI

/// NewFoodView is a form for the user to create a new `ShoppingItemCore`. Default values can be used, or values passed into view as inputs.
struct NewFoodView: View {
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: DateObservableObject
    
    @State var name : String = ""
    @State var note : String = ""
    @State var category : ShopItemCategory = .None
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                    TextField("Amount", text: $note)
                }
                Section(){
                    Picker("Category", selection: $category){
                        ForEach(ShopItemCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
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
    
    /// Add a new entry to the ``ShoppingItemCore`` CoreData storage
    func addFood() {
        let newShoppingItem = ShoppingItemCore(context: viewContext)
        newShoppingItem.name = name
        newShoppingItem.measure = note
        newShoppingItem.category = category.rawValue
        
        settings.selectedEvent?.addToShoppingItemCore(newShoppingItem)
        
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    
}

