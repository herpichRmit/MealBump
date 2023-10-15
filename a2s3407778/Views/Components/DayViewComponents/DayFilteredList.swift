//
//  FilteredList.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 27/9/2023.
//

import SwiftUI
import CoreData

/// View which displays each event as a DayEventTile within the DayView.swift. Seperated from the DayView.swift file to avoid fetch request issues. Date must be passed
/// Into the init() in this file in order to generate the fetch request.
struct DayFilteredList: View {
    
    //    MARK: Variables and Fetch Requests
    
    @State var refreshTrigger : Bool = false
    
    //For accessing CoreData
    @Environment(\.managedObjectContext) private var viewContext
    
    //New Request to initialize in init()
    @FetchRequest var fetchRequest: FetchedResults<EventCore>
    
    //    @State private var activeItemIds: [Int] = []
    
    init(filter: Date){
        // Sort order by order
        let orderSort = NSSortDescriptor(key: "order", ascending: true)
        
        // Constructing filter predicate
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: filter)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end! as NSDate)
        // Need to get range because dates have times associated with them
        
        //        // %K and %@ are format specifiers
        //        // %K var arg substitution for a keypath (coredata attribute)
        //        // %@ var arg substitution for an object
        
        // Underscore means we are changing the wrapper itsself rather than the value stored
        _fetchRequest = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
    }
    
    //MARK: Main styling of the view
    var body: some View {
        
        List {
            ForEach (fetchRequest) { item in
                HStack{
                    DayEventTile(
                        title: (item.name ?? "Unknown"),
                        note: (item.note ?? ""),
                        eventType: (item.eventType ?? ""),
                        mealKind: (item.mealKind ?? ""))
                    .padding(.horizontal, 16.0)
                    .padding(.bottom, 4.0)
                }
                .listRowSeparator(.hidden)
                
            }
            .onDelete(perform: deleteEvent)
            .onMove(perform: moveActiveTodos)
            
            CustomMenu(refreshTrigger: $refreshTrigger).frame(maxWidth: .infinity, alignment: .center)
        }
        .listStyle(.plain)
    }
    
    /// Function to change the order value in each event when events are re-ordered by dragging and dropping
    func moveActiveTodos( from source: IndexSet, to destination: Int) {
        // Make an array of items from fetched results
        var revisedItems: [ EventCore ] = fetchRequest.map{ $0 }
        
        // change the order of the items in the array
        revisedItems.move(fromOffsets: source, toOffset: destination )
        
        // update the userOrder attribute in revisedItems to
        // persist the new order. This is done in reverse order
        // to minimize changes to the indices.
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[ reverseIndex ].order = Int16( reverseIndex )
        }
        saveData()
    }
    
    /// Function to delete events from CoreData when triggered in interface
    func deleteEvent(at offset: IndexSet) {
        //       Identifying the item to delete
        offset.map{fetchRequest[$0]}
            .forEach(viewContext.delete)
        
        saveData()
    }
    
    /// Function to save the data from the Managed Object Context to persistent store
    func saveData() {
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
}
