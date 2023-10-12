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
    
    @State private var note = ""
    @State private var date = Date()
    //    @State private var
    
    
    var body: some View {
        NavigationStack(){
            Form {
                
                Section(){
                    TextField("Note", text: $note)
                    //                    TextField("Time period", text: $timePeriod)
                    TextField("Note", text: $note)
                }
            }
        }
        
        // Adding data to new EventCore Object
        //        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        //        newEvent.date = settings.selectedDate //Add events to the selected date
        //        newEvent.name = chosenName
        //        newEvent.note = chosenNote
        //        newEvent.order = Int16(chosenOrder)
        //        newEvent.timePeriod = chosenTimePeriod
        //        newEvent.type = chosenType
        //        newEvent.        
        // Saving data
        //        do {
        //            try viewContext.save() //Saving data to the persistent store
        //        } catch {
        //            let nserror = error as NSError
        //            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        //        }
    }
}

struct NewShoppingTripSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewShoppingTripSheet()
    }
}
