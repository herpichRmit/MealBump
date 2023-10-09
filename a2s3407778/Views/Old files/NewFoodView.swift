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
        /*
         
         Functionlity to add food to coreData
         
         */
        
    }
    
    
}

