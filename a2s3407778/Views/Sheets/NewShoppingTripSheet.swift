//
//  NewShoppingTripSheet.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

struct NewShoppingTripSheet: View {
    @Environment(\.dismiss) var dismiss //a dismiss variable to be used inside a button later
    
    @EnvironmentObject var settings: DateObservableObject // Object to access custom environment variable
    
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData
    
    @State private var name = "Shopping Trip"
    @State private var note = ""
    @State private var date = Date.now
    
    
    var body: some View {
        
        NavigationStack(){
            Form {
                
                Section(){
                    TextField("Name", text: $name)
                }
                Section(){
                    //                    Date picker only allows option of dates in the future
                    //                    Must use SwiftUI.DatePicker because of our custom View named DatePicker
                    SwiftUI.DatePicker(selection: $date, in: Date.now..., displayedComponents: .date) {
                        Text("Select a date")
                    }
                    
                    TextField("Note", text: $note)

                }
            }
            .navigationBarTitle(Text("New Shopping Trip"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                saveItem()
                dismiss()
            }, label: {
                Text("Done")
            }))
        }
    }
    
    
    func saveItem() {
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        newEvent.date = date
        newEvent.name = name
        newEvent.note = note
        newEvent.order = Int16(100)
//        newEvent.timePeriod = EventTimePeriod.allCases.randomElement()?.rawValue
//        newEvent.type = EventType.allCases.randomElement()?.rawValue
        newEvent.archived = false
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
}

struct NewShoppingTripSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewShoppingTripSheet()
    }
}
