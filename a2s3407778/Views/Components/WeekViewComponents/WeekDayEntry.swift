//
//  WeekDayEntry.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI
import UniformTypeIdentifiers


/// WeekDayEntry contains rows of card views with different events, for a specific day each
struct WeekDayEntry: View {
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @FetchRequest var events: FetchedResults<EventCore> //New Request to initialize in init()
    @EnvironmentObject var settings: DateObservableObject

    let dateToDisplay: Date
    
    // Initalise fetch request to recieve data from a given variable date
    init(filter: Date){
        // Sort order by order
        self.dateToDisplay = filter
        
        let orderSort = NSSortDescriptor(key: "order", ascending: true)
        
        // Constructing filter predicate
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: filter)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end! as NSDate)
        
        // Underscore means we are changing the wrapper itsself rather than the value stored
        _events = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
    }
    
    @State var arrayMeals : [EventCore] = []
    @State var draggedItem : EventCore?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            // Weekday Headings
            VStack(alignment: .leading) {
                Text(weekdayFromDate(date: dateToDisplay))
                    .font(.system(size: 16))
                Text(dayNumberFromDate(date: dateToDisplay))
                    .font(.system(size: 19))
            }
            
            // Row of cards
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack {
                    ForEach(arrayMeals) { item in
                            WeekEventCard(
                                    title: item.name ?? "Unknown Name",
                                    mealKind: item.mealKind ?? "Unknown Time Period",
                                    type: item.eventType ?? "Unknown Type"
                                )
                                .onDrag({
                                    self.draggedItem = item
                                    return NSItemProvider(object: item)
                                })
                                .onDrop(of: [UTType.event], delegate: WeekCardDropDelegate(item: item, items: $arrayMeals, draggedItem: $draggedItem))
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
                    .onDelete(perform: deleteEvent)
                    
                    // Contains links to all sheets though the pop-up menu
                    CustomMenu()
                }
                .frame(height: 110, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
                .onAppear(){
                    arrayMeals = events.map { $0 }
                    print(arrayMeals)
                    //print(arrayMeals[0].name)
                }
            }
        }
        .frame(height: 155, alignment: .topLeading)
    }
    
    /// Removes event from ``EventCore`` using `indexSet` provided by forEach
    func deleteEvent(at offset: IndexSet) {
        //       Identifying the item to delete
        offset.map{events[$0]}
            .forEach(viewContext.delete)
        
        saveData()
    }
    
    /// Helper function to save data to ``EventCore``
    func saveData() {
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
}


struct WeekCardDropDelegate : DropDelegate {
    let item : EventCore
    @Binding var items : [EventCore]
    @Binding var draggedItem : EventCore?
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else {
            return
        }
        if draggedItem != item {
            let from = items.firstIndex(of: draggedItem)!
            let to = items.firstIndex(of: item)!
            withAnimation(.default) {
                self.items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}
