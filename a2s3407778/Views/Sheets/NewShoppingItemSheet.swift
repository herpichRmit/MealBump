//
//  NewShoppingItemSheet.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 12/10/2023.
//

import SwiftUI

struct NewShoppingItemSheet: View {
    @Environment(\.dismiss) var dismiss //a dismiss variable to be used inside a button later
    
    @EnvironmentObject var settings: DateObservableObject // Object to access custom environment variable
    
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData
    
    @State private var name = ""
    @State private var measure = ""
    @State private var category = ""
    
    var body: some View {
        
        NavigationStack(){
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                }
                Section(){
                    
                }
                
                TextField("Note", text: $measure)
                Picker ("Category", selection: $category) {
                    ForEach(ShopItemCategory.allCases) { option in
                        Text(option.rawValue)
                    }
                }
            }
            .navigationBarTitle(Text("Placeholder"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                saveItem()
                dismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
    func saveItem() {
        // Adding data to new ShoppingItemCore Object
        let newShoppingItem = ShoppingItemCore(context: viewContext)
        newShoppingItem.name = name
        newShoppingItem.measure = measure
        newShoppingItem.category = category
        newShoppingItem.checked = false
        
        // Saving data
        if viewContext.hasChanges {
            do {
                try viewContext.save() //Saving data to the persistent store
            } catch {
                let nserror = error as NSError
                fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
