//
//  WeekDayEntry.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI
<<<<<<< Updated upstream
=======
//import SwiftUIReorderableForEach // package as seen in https://iosexample.com/drag-drop-to-reorder-items-in-swiftui/
import Algorithms
>>>>>>> Stashed changes

// WeekDayEntry shows the weekday, weeknumber and holds all of the meal cards

struct WeekDayEntry: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    
    @FetchRequest var fetchRequest: FetchedResults<EventCore> //New Request to initialize in init()
    
    @EnvironmentObject var settings: DateObservableObject
    
    let headingDate: Date
    
    init(startDate: Date, endDate: Date){
        // Sort order by order
        self.headingDate = startDate
        
        let orderSort = NSSortDescriptor(key: "order", ascending: true)
        
        // Constructing filter predicate
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.date(byAdding: .day, value: 1, to: endDate) // Date will be received at 12am, so need to add another day to get range
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end! as NSDate)
        
        // Underscore means we are changing the wrapper itself rather than the value stored
        _fetchRequest = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
    }
    
<<<<<<< Updated upstream
=======
    @State private var monday: [WeekEventCard] = [WeekEventCard(title: "Spagetti Bolognese", mealKind: "Dinner", type: "Meal"),
                                                  WeekEventCard(title: "Savoys and Hummus", mealKind: "Snack", type: "Meal"),
                                                  WeekEventCard(title: "Thai Green Curry", mealKind: "Dinner", type: "Meal"),]
    @State private var tuesday: [WeekEventCard] = [WeekEventCard(title: "Shopping Trip", mealKind: "", type: "ShoppingTrip")]
    @State private var wednesday: [WeekEventCard] = [WeekEventCard(title: "Banana", mealKind: "Snack", type: "Meal")]
    @State private var thursday: [WeekEventCard] = [WeekEventCard(title: "Other Event", mealKind: "", type: "Other")]
    @State private var friday: [WeekEventCard] = [WeekEventCard(title: "Rueben Sandwich", mealKind: "Lunch", type: "Meal")]
    @State private var saturday: [WeekEventCard] = [WeekEventCard(title: "Eggs on Toast", mealKind: "Breakfast", type: "Meal")]
    @State private var sunday: [WeekEventCard] = [WeekEventCard(title: "Chili Con Carne", mealKind: "Dinner", type: "Meal")]
    
    @State private var draggedEventItem: WeekEventCard?
    
>>>>>>> Stashed changes
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false){ //Vertical Scrolling of the week
            
            VStack(alignment: .leading, spacing: 5) {
                // Weekday Headings
                Text(weekdayFromDate(date: headingDate))
                    .font(.system(size: 16))
                Text(dayNumberFromDate(date: headingDate))
                    .font(.system(size: 19))
                
                // row of cards
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach (monday, id:\.id) { item in //Printing out items in a day, horizontally
                            item //This is the WeekEventCard, but called from a foreach loop
                            // Dragging logic
                                .draggable(item)
                            
                            // Dropping logic
                                .dropDestination(for: WeekEventCard.self) { items, location in //Making the horizontal list a drag destination
                                    draggedEventItem = items.first
                                    print(location)
                                    return true
                                }  isTargeted: { inDropArea in
                                }
                        }
                        .listRowSeparator(.hidden)
                        
                        CustomMenu()
                    }
                }
                //                    .frame(height: 120, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
            }
            
<<<<<<< Updated upstream
            // Row of cards
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(events) { item in
                        HStack{
                            WeekEventCard(
                                    title: item.name ?? "Unknown Name",
                                    mealKind: item.mealKind ?? "Unknown Time Period",
                                    type: item.eventType ?? "Unknown Type"
                                )
                                .onTapGesture(count: 2, coordinateSpace: .global) { location in
                                    settings.cardPosition = location
                                    settings.selectedPickupCard = item
                                
                                    // call function to remove event date temporarily
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        settings.selectedPickupCard?.date = Date()
                                        saveData()
                                    }
                                }
                                Spacer()
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteEvent)
                    .onMove(perform: moveActiveTodos)
                    
                    CustomMenu()
=======
            
            VStack(alignment: .leading, spacing: 5) {
                // Weekday Headings
                Text("Tuesday")
                    .font(.system(size: 16))
                Text(dayNumberFromDate(date: headingDate))
                    .font(.system(size: 19))
                
                // row of cards
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach (tuesday, id:\.id) { item in //Printing out items in a day, horizontally
                            item //This is the WeekEventCard, but called from a foreach loop
                            // Dragging logic
                                .draggable(item)
                            
                            // Dropping logic
                                .dropDestination(for: WeekEventCard.self) { items, location in //Making the horizontal list a drag destination
                                    draggedEventItem = items.first
                                    print(location)
                                    return true
                                }  isTargeted: { inDropArea in
                                }
                        }
                        .listRowSeparator(.hidden)
                        
                        CustomMenu()
                    }
>>>>>>> Stashed changes
                }
                //                    .frame(height: 120, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
                

            }
        }
    }
    
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
    }
}
