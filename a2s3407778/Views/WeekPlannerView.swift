//
//  WeekPlannerView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

struct WeekPlannerView: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @EnvironmentObject var settings: DateObservableObject
    
    // All of the events read from the json file
    //var events: [Event] = Event.allEvents
    //    var datesInWeek
    
    // Controls if a modal is being shown and which one
    //    @State var isMenuShown = false
    //    @State var showActionSheet = false
    //    @State var showCreateMealSheet = false
    //    @State var showCreateShopSheet = false
    //    @State var showCreateOtherSheet = false
    //    @State var showSearchMealSheet = false
    //  @State var showActionSheet = false
    //@State var activateSheetPosition: CGPoint = .zero
    
    
    @State var selectedEvent: EventCore?
    @State private var animatedTrigger: Bool = false
    @State var cardPosition: CGPoint = CGPoint(x: 0, y: 0)
    let cardStartPoint: CGPoint = CGPoint(x: 300, y: 600)
    
    // Partition events into several arrays of events by day
    
    init() {
    }
    
    
    
    
    var body: some View {
        
        NavigationView {
            ZStack(){
                
                if selectedEvent != nil {
                    WeekEventCard(
                        title: selectedEvent?.name ?? "Unknown title",
                        mealKind: selectedEvent?.mealKind ?? "Unknown mealKind",
                        type: selectedEvent?.eventType ?? "Unknown eventType"
                    )
                    .animation(.easeInOut, value: animatedTrigger)
                    .zIndex(1)
                    .position(cardPosition) // where the card is double tapped
                    .position(cardPosition) // where the card is double tapped
                    .shadow(color: Color.white.opacity(0.07), radius: 15, x: 4, y: 10)
                    .onAppear{
                        animateCardSelect(location: cardPosition) // move card to spot
                    }
                }
                
                // list of days
                VStack{
                    HStack{
                        Text("**Weekly Planner** August")
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                    
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // pass in 0..7 dates
                            // within WeekDayEntry -> fetch request
                            
                            // create a row for each day
                            ForEach(generateDateArray(selectedDate: settings.selectedDate), id: \.self) { day in
                                WeekDayEntry(
                                    filter: day//,
                                    //                                            selectedEvent: $selectedEvent,
                                    //                                            cardPosition: $cardPosition,
                                    //                                            buildActionSheet: $buildActionSheet,
                                    //                                            activateSheetPosition: $activateSheetPosition
                                )
                                .onTapGesture { location in
                                    // dropping card
                                    if selectedEvent != nil {
                                        animateCardPlace(location: location)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            
                                            // changing selectedEvent to have new date
                                            
                                            // call update event with new date
                                            
                                            selectedEvent?.date = day
                                            
                                            /*
                                             var updatedDay = eventsByDay[index] // Create a mutable copy
                                             updatedDay.removeAll {
                                             $0.id == selectedEvent[0]!.id // delete date from original day
                                             }
                                             updatedDay.append(selectedEvent[0]!) // save event to new day
                                             eventsByDay[index] = updatedDay
                                             selectedEvent.removeAll() // clear selected event
                                             */
                                        }
                                    }
                                }
                                
                            }
                            
                            
                            
                        }
                    }
                    .frame(minHeight: 300, alignment: .topLeading)
                    .padding( [.leading] )
                }
                
                
                // When the plus button in DayEntry->sheetView is pressed, custom action sheet below is activated
                AnimationOverlay()
                
                
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

// Unwrapping tool used from stack overflow
// TODO: from https://stackoverflow.com/questions/57021722/swiftui-optional-textfield

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

/*
 func partitionByDate(currentDate: Date) -> [[Event]] {
 
 var dayArrEvents : [Event] = []
 var weekOfDays : [[Event]] = []
 let formatter = DateFormatter()
 
 // collect all meals under same date create and array of days
 formatter.dateFormat = "YYYY-MM-dd"
 let anchor = formatter.date(from: "2023-08-7") ?? Date()
 let calendar = Calendar.current
 
 for dayOffset in 0...6 {
 if let date = calendar.date(byAdding: .day, value: dayOffset, to: anchor) {
 
 dayArrEvents = []
 for targetEvent in events {
 if targetEvent.date == date {
 //print("succesful")
 //print(targetEvent)
 dayArrEvents.append(targetEvent)
 }
 }
 
 if dayArrEvents != [] {
 // if dayArrEvents has items append
 weekOfDays.append(dayArrEvents)
 
 } else {
 // else just provide date info
 weekOfDays.append([Event(id: 98, title: "n/a", desc: "", date: date, order: 99, eventType: TypeEnum.meal, timeLabel: "", foodItems: [[]])])
 
 }
 
 }
 
 }
 
 return weekOfDays
 
 }
 */



struct WeekPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerView()
    }
}
