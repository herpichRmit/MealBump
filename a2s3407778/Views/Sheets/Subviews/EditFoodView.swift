//
//  EditFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

/// EditFoodView provides a form for users to enter details of a food item they want to add to a meal. The exisiting food details can be passed in when the view is called.
struct EditFoodView: View {
    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: DateObservableObject
    
    // Default values for form.
    @State var item : ShoppingItemCore
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
            .navigationBarItems(trailing: Button("Save", action: {
                updateFood()
                dismiss()
            }))
        }
        .onAppear(){
            // Initalise form placeholders with passed in or empty values.
            name = item.name ?? ""
            note = item.measure ?? ""
            category = ShopItemCategory(rawValue: item.category ?? "None") ?? .None
        }
    }
    
    /// Update the ``ShoppingItemCore`` CoreData storage
    func updateFood() {
        item.name = name
        item.category = category.rawValue
        item.measure = note
        
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
        
        
    }
    
}
