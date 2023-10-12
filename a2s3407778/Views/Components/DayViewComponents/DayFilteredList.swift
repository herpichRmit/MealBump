//
//  FilteredList.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 27/9/2023.
//

import SwiftUI
import CoreData

struct DayFilteredList: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    
    @FetchRequest var fetchRequest: FetchedResults<EventCore> //New Request to initialize in init()
    
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
//                    VStack{ // Added for testing date and order sorting
//                        Text("\(item.order)") // To Test the order sorting is working
//                        Text(dateToString(date: item.date!)) // TO Test date seperation is working
//                    }
                }
                .listRowSeparator(.hidden)

            }
            .onDelete(perform: deleteEvent)
            .onMove(perform: moveActiveTodos)
        }
        .listStyle(.plain)
    }
    
    //    func moveActiveTodos(fromOffsets source: IndexSet, toOffset destination: Int) {
    //      activeItemIds.move(fromOffsets: source, toOffset: destination)
    //    }
    
    private func moveActiveTodos( from source: IndexSet, to destination: Int) {
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
    
    func deleteEvent(at offset: IndexSet) {
        //       Identifying the item to delete
        offset.map{fetchRequest[$0]}
            .forEach(viewContext.delete)
        
        saveData()
    }
    
    func saveData() {
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
}
