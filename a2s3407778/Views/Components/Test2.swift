//
//  Test2.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 19/9/2023.
//

import SwiftUI

struct Test2: View {
    let rows = Array(repeating: GridItem(.flexible(), spacing: 45), count: 2)
    
    var event1 = Event(id: 1, title: "Birthday Party", desc: "Celebrate John's birthday", date: Date(), order: 1, type: .meal, timeLabel: "6:00 PM", foodItems: [["Cake", "Pizzas", "Soda"]])

    var event2 = Event(id: 2, title: "Grocery Shopping", desc: "Buy groceries for the week", date: Date().addingTimeInterval(86400), order: 2, type: .shoppingTrip, timeLabel: "10:00 AM", foodItems: [["Apples", "Milk", "Bread"]])

    var event3 = Event(id: 3, title: "Lunch Meeting", desc: "Discuss project with the team", date: Date().addingTimeInterval(172800), order: 3, type: .meal, timeLabel: "12:30 PM", foodItems: [["Sandwiches", "Salad", "Water"]])

    var event4 = Event(id: 4, title: "Skipped Breakfast", desc: "No time for breakfast today", date: Date().addingTimeInterval(259200), order: 4, type: .skippedMeal, timeLabel: "", foodItems: nil)

    var event5 = Event(id: 5, title: "Dinner with Friends", desc: "Enjoy a night out with friends", date: Date().addingTimeInterval(345600), order: 5, type: .meal, timeLabel: "7:00 PM", foodItems: [["Pasta", "Wine", "Dessert"]])

    @State private var mondayEvents: [Event] = []
    @State private var tuesdayEvents: [Event] = []

    @State private var squarePosition: CGPoint = CGPoint(x: 100, y: 100)
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        
        VStack{
            Day2(title: "Monday", events: mondayEvents)
                .dropDestination(for: Event.self) { droppedEvents, location in
                    for event in droppedEvents{
                        tuesdayEvents.removeAll { $0.id == event.id }
                    }
                    let positionIndex = 2
                    mondayEvents.insert(contentsOf: droppedEvents, at: positionIndex)
                    let totalEvents = mondayEvents
                    mondayEvents = Array(totalEvents.uniqued())
                    return true
                }
            
            }
        .onAppear {
            mondayEvents = [event1, event2, event3, event4, event5]
            tuesdayEvents = [event1, event2, event3, event4, event5]
        }
        
        

    }
}

struct Day2 : View {
    
    let title: String
    let events: [Event]
    
    @State private var firstEvent: [Event] = []
    @State private var secondEvent: [Event] = []
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            
            Text(title)
            ZStack{
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(.secondarySystemFill))
                
                HStack {
                    
                    //ForEach(events, id: \.id){ event in
                        //Card(event: event)
                        //    .draggable(event)
                        //Text(event.title)
                        //    .padding(12)
                        //    .background(Color(uiColor: .secondarySystemGroupedBackground))
                        //    .draggable(event)
                        //Box(event: event)
                            
                            
                    //}
                    
                    //Box(event: events)
                    Box()
                }
                
            }
            
            
        }
        
    }
}

struct Box : View {
    
    
    @State var event1 = Event(id: 1, title: "Birthday Party", desc: "Celebrate John's birthday", date: Date(), order: 1, type: .meal, timeLabel: "6:00 PM", foodItems: [["Cake", "Pizzas", "Soda"]])

    @State var event2 = Event(id: 2, title: "Grocery Shopping", desc: "Buy groceries for the week", date: Date().addingTimeInterval(86400), order: 2, type: .shoppingTrip, timeLabel: "10:00 AM", foodItems: [["Apples", "Milk", "Bread"]])

    //@State var events: Event
    
    @State var box1isTargeted: Bool = false
    @State var box2isTargeted: Bool = false
    
    var body: some View {
        HStack{
            
            BoxContainer(event: event1, isTargeted: box1isTargeted)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                    for newEvent in droppedEvents{
                        // Create a copy of the new event
                        var updatedEvent = newEvent
                        
                        // Switch event order
                        //updatedEvent.order = event1.order
                        
                        // Update event with the modified values
                        event1 = updatedEvent
                        
                        // find item with new event and change to event1
                        // do this through binding?
                    }
                    //let positionIndex = 2
                    //mondayEvents.insert(contentsOf: droppedEvents, at: positionIndex)
                    //let totalEvents = mondayEvents
                    //mondayEvents = Array(totalEvents.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    box1isTargeted = isTargeted
                }
            BoxContainer(event: event2, isTargeted: box2isTargeted)
                    .dropDestination(for: Event.self) { droppedEvents, location in
                    for newEvent in droppedEvents{
                        // Create a copy of the new event
                        var updatedEvent = newEvent
                        
                        // Switch event order
                        //updatedEvent.order = event2.order
                        
                        // Update event with the modified values
                        event2 = updatedEvent
                        print(event2)
                    }
                    //let positionIndex = 2
                    //mondayEvents.insert(contentsOf: droppedEvents, at: positionIndex)
                    //let totalEvents = mondayEvents
                    //mondayEvents = Array(totalEvents.uniqued())
                    return true
                } isTargeted: { isTargeted in
                    box2isTargeted = isTargeted
                }
            
            
        }

    }
}

struct BoxContainer: View {
    
    let event: Event
    let isTargeted: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 100, height: 100)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))

            Text("\(event.title) \(String(event.order))")
                .frame(width: 80, height: 80)
                .foregroundColor(Color(.systemPink))
                .draggable(event)
        }
        
    }
}


struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
