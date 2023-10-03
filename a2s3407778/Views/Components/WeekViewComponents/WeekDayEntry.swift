//
//  DayEntry.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI
import SwiftUIReorderableForEach // package as seen in https://iosexample.com/drag-drop-to-reorder-items-in-swiftui/

// DayEntry shows the weekday, weeknumber and holds all of the meal cards

struct WeekDayEntry: View {
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    
    @FetchRequest var events: FetchedResults<EventCore> //New Request to initialize in init()
    
    @EnvironmentObject var settings: DateObservableObject

    
    // allows for select card functionality
//    @Binding var selectedEvent: EventCore
//    @Binding var cardPosition: CGPoint
    
    // allows for reordering of cards
//    @State var isMoveable : Bool = true
    
    // control what modal is being shown
    //    @Binding var isMenuShown : Bool
    //    @Binding var showActionSheet : Bool
    //    @Binding var showCreateMealSheet : Bool
    //    @Binding var showCreateShopSheet : Bool
    //    @Binding var showCreateOtherSheet : Bool
    //    @Binding var showSearchMealSheet : Bool
    //    @Binding var buildActionSheet : Bool
    //    @Binding var activateSheetPosition : CGPoint
    
    let dateToDisplay: Date
    
    init(filter: Date){
        // Sort order by order
        self.dateToDisplay = filter
        
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
        _events = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            // Weekday Headings
            VStack(alignment: .leading) {
                Text(weekdayFromDate(date: dateToDisplay))
                    .font(.system(size: 16))
                Text(dayNumberFromDate(date: dateToDisplay))
                    .font(.system(size: 19))
            }
            
            // row of cards
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach (events) { item in
                        HStack{
                            WeekEventCard(title: item.name ?? "Unknown Name",
                                          timePeriod: item.timePeriod ?? "Unknown Time Period",
                                          type: item.type ?? "Unknown Type")
                            .onTapGesture(count: 2, coordinateSpace: .global) { location in
//                                cardPosition = location
//                                selectedEvent = item
                                
                                /*
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                 events.removeAll { $0.id == selectedEvent[0]!.id }
                                 }
                                 */
                            }
                            Spacer()
                            //                            }
                            //                    VStack{ // Added for testing date and order sorting
                            //                        Text("\(item.order)") // To Test the order sorting is working
                            //                        Text(dateToString(date: item.date!)) // TO Test date seperation is working
                            //                    }
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .onDelete(perform: deleteEvent)
                    .onMove(perform: moveActiveTodos)
                    
                    
                    
                    // sheet view contains all the different modal sheets and forms
                    //                        SheetView(
                    //                            date: date,
                    //                            isMenuShown: $isMenuShown,
                    //                            showActionSheet: $showActionSheet,
                    //                            showCreateMealSheet: $showCreateMealSheet,
                    //                            showCreateShopSheet: $showCreateShopSheet,
                    //                            showCreateOtherSheet: $showCreateOtherSheet,
                    //                            showSearchMealSheet: $showSearchMealSheet,
                    //                            buildActionSheet: $buildActionSheet,
                    //                            activateSheetPosition: $activateSheetPosition,
                    //                            date: date,
                    //                            filter: currDate)
                    
                }
                .frame(height: 140, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
            }
        }
        .frame(height: 150, alignment: .topLeading)
    }
    
    func moveActiveTodos( from source: IndexSet, to destination: Int) {
        // Make an array of items from fetched results
        var revisedItems: [ EventCore ] = events.map{ $0 }
        
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
        offset.map{events[$0]}
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




