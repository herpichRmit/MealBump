//
//  WeekPlannerView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

struct WeekPlannerView: View {
    
    // All of the events read from the json file
    var events: [Event] = Event.allEvents
    @State var eventsByDay : [[Event]]
    
    // Controls if a modal is being shown and which one
    @State var isMenuShown = false
    @State var showActionSheet = false
    @State var showCreateMealSheet = false
    @State var showCreateShopSheet = false
    @State var showCreateOtherSheet = false
    @State var showSearchMealSheet = false
    @State var buildActionSheet = false
    @State var activateSheetPosition: CGPoint = .zero
    
    
    @State private var selectedEvent: [Event?] = []
    @State private var animatedTrigger: Bool = false
    @State private var cardPosition: CGPoint = CGPoint(x: 0, y: 0)
    let cardStartPoint: CGPoint = CGPoint(x: 300, y: 600)

    // Partition events into several arrays of events by day
    init() {
        self.eventsByDay = partitionByDate(events: events)
    }

    var body: some View {
        
            NavigationView {
                ZStack(){
                    
                    if !selectedEvent.isEmpty {
                        Card(event: selectedEvent[0]!)
                            .animation(.easeInOut, value: animatedTrigger)
                            .zIndex(1)
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
                                
                                // create a row for each day
<<<<<<< HEAD
                                ForEach(eventsByDay, id: \.self) { day in
                                    WeekDayEntry(dayInfo: day, isMenuShown: $isMenuShown, showActionSheet: $showActionSheet, showCreateMealSheet: $showCreateMealSheet, showCreateShopSheet: $showCreateShopSheet, showCreateOtherSheet: $showCreateOtherSheet, showSearchMealSheet: $showSearchMealSheet)
||||||| 0cacb4a
                                ForEach(eventsByDay, id: \.self) { day in
                                    DayEntry(dayInfo: day, isMenuShown: $isMenuShown, showActionSheet: $showActionSheet, showCreateMealSheet: $showCreateMealSheet, showCreateShopSheet: $showCreateShopSheet, showCreateOtherSheet: $showCreateOtherSheet, showSearchMealSheet: $showSearchMealSheet)
=======
                                ForEach(Array(eventsByDay.enumerated()), id: \.element) { (index, day) in
                                    DayEntry(
                                        events: day,
                                        selectedEvent: $selectedEvent,
                                        cardPosition: $cardPosition,
                                        isMenuShown: $isMenuShown,
                                        showActionSheet: $showActionSheet,
                                        showCreateMealSheet: $showCreateMealSheet,
                                        showCreateShopSheet: $showCreateShopSheet,
                                        showCreateOtherSheet: $showCreateOtherSheet,
                                        showSearchMealSheet: $showSearchMealSheet,
                                        buildActionSheet: $buildActionSheet,
                                        activateSheetPosition: $activateSheetPosition
                                    )
                                    .onTapGesture { location in
                                        if !selectedEvent.isEmpty {
                                            animateCardPlace(location: location)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                var updatedDay = eventsByDay[index] // Create a mutable copy
                                                updatedDay.removeAll {
                                                    $0.id == selectedEvent[0]!.id
                                                }
                                                updatedDay.append(selectedEvent[0]!)
                                                eventsByDay[index] = updatedDay // Update the original array
                                                selectedEvent.removeAll()
                                            }
                                        }
                                    }
>>>>>>> main
                                }

                                
                                
                            }
                        }
                        .frame(minHeight: 300, alignment: .topLeading)
                        .padding( [.leading] )
                    }
                    
                    // Used to exit blur background and exit popup if tapped outside of buttons
                    if isMenuShown {
                        VStack(alignment: .leading){
                            HStack {
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(.regularMaterial)
                        .opacity(0.9)
                        .blur(radius: 10, opaque: false)
                        .onTapGesture {
                            isMenuShown = false
                        }
                    }
                    
                    
                    
                    // When the plus button in DayEntry->sheetView is pressed, custom action sheet below is activated
                    
                    
                    if buildActionSheet{
                        
                        // we want to build initial layout after button is pressed
                        // then we want to switch instanly
                        let layout = isMenuShown ? AnyLayout(RadialLayout()) : AnyLayout(InitialLayout())
                        
                        layout {
                            Bubble(colour: Color("Color 1"), text: "Archive", active: isMenuShown)
                                .onTapGesture{
                                    isMenuShown.toggle() //Hides the buttons once pressed
                                    showSearchMealSheet.toggle()
                                }
                                .onAppear(){
                                    print("testB")
                                    print(activateSheetPosition)
                                }
                                .layoutValue(key: StartPosition.self, value: activateSheetPosition)
                            Bubble(colour: Color("Color 2"), text: "Shopping", active: isMenuShown)
                                .onTapGesture{
                                    isMenuShown.toggle() //Hides the buttons once pressed
                                    showCreateShopSheet.toggle()
                                }
                                .onAppear(){
                                    print("testB")
                                    print(activateSheetPosition)
                                }
                                .layoutValue(key: StartPosition.self, value: activateSheetPosition)
                            Bubble(colour: Color("Color 3"), text: "Meal", active: isMenuShown)
                                .onTapGesture{
                                    isMenuShown.toggle() //Hides the buttons once pressed
                                    showCreateMealSheet.toggle()
                                }
                                .onAppear(){
                                    print("testB")
                                    print(activateSheetPosition)
                                }
                                .layoutValue(key: StartPosition.self, value: activateSheetPosition)
                            Bubble(colour: Color("Color 4"), text: "Other", active: isMenuShown)
                                .onTapGesture{
                                    isMenuShown.toggle() //Hides the buttons once pressed
                                    showCreateOtherSheet.toggle()
                                }
                                .onAppear(){
                                    print("testB")
                                    print(activateSheetPosition)
                                }
                                .layoutValue(key: StartPosition.self, value: activateSheetPosition)
                            
                        }
                        .animation(.easeInOut(duration: 0.2))
                        
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


// Unwrapping tool used from stack overflow
// TODO: from https://stackoverflow.com/questions/57021722/swiftui-optional-textfield

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}


func partitionByDate(events: [Event] ) -> [[Event]] {
    
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
                weekOfDays.append([Event(id: 98, title: "n/a", desc: "", date: date, order: 99, type: TypeEnum.meal, timeLabel: "", foodItems: [[]])])

            }
                        
        }
        
    }
    
    return weekOfDays
    
}



struct WeekPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerView()
    }
}
