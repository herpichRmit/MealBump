//
//  DragDropGrid.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 18/9/2023.
//

import SwiftUI
import Algorithms
import SwiftUIReorderableForEach

struct DragDropGrid: View {
    
    let rows = Array(repeating: GridItem(.flexible(), spacing: 45), count: 2)
    
    let event1 = Event(id: 1, title: "Birthday Party", desc: "Celebrate John's birthday", date: Date(), order: 1, type: .meal, timeLabel: "Breakfast", foodItems: [["Cake", "Pizzas", "Soda"]])

    let event2 = Event(id: 2, title: "Grocery Shopping", desc: "Buy groceries for the week", date: Date().addingTimeInterval(86400), order: 2, type: .shoppingTrip, timeLabel: "10:00 AM", foodItems: [["Apples", "Milk", "Bread"]])

    let event3 = Event(id: 3, title: "Lunch Meeting", desc: "Discuss project with the team", date: Date().addingTimeInterval(172800), order: 3, type: .meal, timeLabel: "12:30 PM", foodItems: [["Sandwiches", "Salad", "Water"]])

    let event4 = Event(id: 4, title: "Skipped Breakfast", desc: "No time for breakfast today", date: Date().addingTimeInterval(259200), order: 4, type: .skippedMeal, timeLabel: "", foodItems: nil)

    let event5 = Event(id: 5, title: "Dinner with Friends", desc: "Enjoy a night out with friends", date: Date().addingTimeInterval(345600), order: 5, type: .meal, timeLabel: "7:00 PM", foodItems: [["Pasta", "Wine", "Dessert"]])

    @State private var mondayEvents: [Event] = []
    @State private var tuesdayEvents: [Event] = []
    @State private var wednesdayEvents: [Event] = []

    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                
                RowOfCards(title: "Monday", day: "7", events: $mondayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            tuesdayEvents.removeAll { $0.id == event.id }
                            mondayEvents.append(event)
                        }
                        let totalEvents = mondayEvents
                        mondayEvents = Array(totalEvents.uniqued())
                        return true
                    }
                
                RowOfCards(title: "Tuesday", day: "8", events: $tuesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                
                RowOfCards(title: "Wednesday", day: "9", events: $wednesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                /*
                RowOfCards(title: "Thursday", events: $wednesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                RowOfCards(title: "Friday", events: $wednesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                RowOfCards(title: "Saturday", events: $wednesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                RowOfCards(title: "Sunday", events: $wednesdayEvents)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                        for event in droppedEvents{
                            mondayEvents.removeAll { $0.id == event.id }
                            tuesdayEvents.append(event)
                        }
                        let totalEvents = tuesdayEvents
                        tuesdayEvents = Array(totalEvents.uniqued())
                        
                        return true
                    }
                 */
                
            }
            .onAppear {
                mondayEvents = [event1, event2, event3]
                tuesdayEvents = [event4, event5]
                print(mondayEvents)
            }
            
            
        }
    }
}

struct RowOfCards : View {
    
    let title: String
    let day: String
    @Binding var events: [Event]
    
    @State var isMoveable : Bool = true
    
    @State var dragHorizontal : Bool = true
    
    
    var body: some View {
        
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( [.leading, .top])
        Text(day)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( [.leading])
        
        ScrollView(.horizontal, showsIndicators: false){
            ZStack{
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(dragHorizontal ? .green : .red)
                    .offset(x: -177)
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(idealWidth: 370, maxWidth: .infinity, minHeight:150, maxHeight:150)
                    .foregroundColor(Color(.secondarySystemFill))
                    .onTapGesture(count: 2) {
                        $dragHorizontal.wrappedValue.toggle()
                    }
                
                
                HStack {
                    
                    ReorderableForEach($events, allowReordering: $isMoveable) { item, isDragged in
                        if dragHorizontal {
                            Card(event: item)
                                .draggable(item)
                                .onTapGesture(count: 2) {
                                    $dragHorizontal.wrappedValue.toggle()
                                }
                        } else {
                            Card(event: item)
                                .onTapGesture(count: 2) {
                                    $dragHorizontal.wrappedValue.toggle()
                                }
                        }
                        
                        
                    }
                    Spacer()
                    
                    
                }
                .scenePadding( [.leading])
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(idealWidth: 370, maxWidth: .infinity, minHeight:150, maxHeight:150)
                    .foregroundColor(Color(.clear))
                    .onTapGesture(count: 2) {
                        $dragHorizontal.wrappedValue.toggle()
                    }
                
            }
            .scenePadding( [.leading])
        }
        
        
    }
    

}



struct DragDropGrid_Previews: PreviewProvider {
    static var previews: some View {
        DragDropGrid()
    }
}

