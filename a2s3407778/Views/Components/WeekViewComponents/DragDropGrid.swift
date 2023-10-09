//
//  DragDropGrid.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 18/9/2023.
//

/*
import SwiftUI
import Algorithms

struct testData {
    
    var week = [
        [
            Event(id: 1, title: "Birthday Party", desc: "Celebrate John's birthday", date: Date(), order: 1, type: .meal, timeLabel: "Breakfast", foodItems: [["Cake", "Pizzas", "Soda"]]),
            Event(id: 2, title: "Grocery Shopping", desc: "Buy groceries for the week", date: Date().addingTimeInterval(86400), order: 2, type: .shoppingTrip, timeLabel: "10:00 AM", foodItems: [["Apples", "Milk", "Bread"]])
        ],
        [
            Event(id: 3, title: "Lunch Meeting", desc: "Discuss project with the team", date: Date().addingTimeInterval(172800), order: 3, type: .meal, timeLabel: "12:30 PM", foodItems: [["Sandwiches", "Salad", "Water"]]),
            Event(id: 4, title: "Skipped Breakfast", desc: "No time for breakfast today", date: Date().addingTimeInterval(259200), order: 4, type: .skippedMeal, timeLabel: "", foodItems: nil),
            Event(id: 5, title: "Dinner with Friends", desc: "Enjoy a night out with friends", date: Date().addingTimeInterval(345600), order: 5, type: .meal, timeLabel: "7:00 PM", foodItems: [["Pasta", "Wine", "Dessert"]])
        ]
    
    ]
        
}

struct DragDropGrid: View {
    
    @State private var mondayEvents: [Event] = [
        Event(id: 1, title: "Birthday Party", desc: "Celebrate John's birthday", date: Date(), order: 1, type: .meal, timeLabel: "Breakfast", foodItems: [["Cake", "Pizzas", "Soda"]]),
        Event(id: 2, title: "Grocery Shopping", desc: "Buy groceries for the week", date: Date().addingTimeInterval(86400), order: 2, type: .shoppingTrip, timeLabel: "10:00 AM", foodItems: [["Apples", "Milk", "Bread"]])
    ]
    
    @State private var tuesdayEvents: [Event] = [
        Event(id: 3, title: "Lunch Meeting", desc: "Discuss project with the team", date: Date().addingTimeInterval(172800), order: 3, type: .meal, timeLabel: "12:30 PM", foodItems: [["Sandwiches", "Salad", "Water"]]),
        Event(id: 4, title: "Skipped Breakfast", desc: "No time for breakfast today", date: Date().addingTimeInterval(259200), order: 4, type: .skippedMeal, timeLabel: "", foodItems: nil)
    ]
    
    @State private var selectedEvent: [Event?] = []
    @State private var animatedTrigger: Bool = false
    @State private var cardPosition: CGPoint = CGPoint(x: 0, y: 0)
    let cardStartPoint: CGPoint = CGPoint(x: 300, y: 600)
    
    
    var body: some View {
        
            ZStack{

                if !selectedEvent.isEmpty {
                    WeekEventCard(title: selectedEvent., timePeriod: <#T##String#>, type: <#T##String#>)
                        .animation(.easeInOut, value: animatedTrigger)
                        .zIndex(1)
                        .position(cardPosition) // where the card is double tapped
                        .shadow(color: Color.white.opacity(0.07), radius: 15, x: 4, y: 10)
                        .onAppear{
                            animateCardSelect(location: cardPosition) // move card to spot
                        }
                }
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        
                        RowOfCards(title: "Monday", day: "7", events: $mondayEvents, selectedEvent: $selectedEvent, cardPosition: $cardPosition)
                            .onTapGesture { location in
                                if !selectedEvent.isEmpty {
                                    animateCardPlace(location: location)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        mondayEvents.removeAll { $0.id == selectedEvent[0]!.id }
                                        mondayEvents.append(selectedEvent[0]!)
                                        selectedEvent.removeAll()
                                        print("test")
                                    }
                                    
                                }
                            }
                        
                        
                        RowOfCards(title: "Tuesday", day: "8", events: $tuesdayEvents, selectedEvent: $selectedEvent, cardPosition: $cardPosition)
                            .onTapGesture { location in
                                if !selectedEvent.isEmpty {
                                    animateCardPlace(location: location)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.115) {
                                        tuesdayEvents.removeAll { $0.id == selectedEvent[0]!.id }
                                        tuesdayEvents.append(selectedEvent[0]!)
                                        selectedEvent.removeAll()
                                        print("test")
                                    }
                                    
                                }
                            }
                        
                        
                        
                        

                        
                    }
                    
                }

        }
    }
    
    func animateCardSelect(location: CGPoint) {
            animatedTrigger.toggle()
            cardPosition = location
            withAnimation {
                cardPosition = CGPoint(x:300, y:600)
            }
        }
    
    func animateCardPlace(location: CGPoint) {
            animatedTrigger.toggle()
            withAnimation {
                cardPosition = location
            }
        }
    
}


struct RowOfCards : View {
    
    let title: String
    let day: String
    @Binding var events: [Event]
    @Binding var selectedEvent: [Event?]
    @Binding var cardPosition: CGPoint
    
    @State var isMoveable : Bool = true

    
    var body: some View {
        
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( [.leading, .top])
        Text(day)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( [.leading])
        
        ScrollView(.horizontal, showsIndicators: false){
            ZStack{
                
                HStack {
                    
                    ReorderableStack($events, allowReordering: $isMoveable) { item, isDragged in
                        WeekEventCard(event: item)
                            .onTapGesture(count: 2, coordinateSpace: .global) { location in
                                print(location)
                                cardPosition = location
                                selectedEvent.append(item)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    events.removeAll { $0.id == selectedEvent[0]!.id }
                                }
                            }
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 12)
                    .frame(idealWidth: 370, maxWidth: .infinity, minHeight:150, maxHeight:150)
                    .foregroundColor(Color(.clear))
                
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

*/
