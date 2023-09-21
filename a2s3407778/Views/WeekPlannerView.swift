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
    var eventsByDay : [[Event]]
    
    // Controls if a modal is being shown and which one
    @State var isMenuShown = false
    @State var showActionSheet = false
    @State var showCreateMealSheet = false
    @State var showCreateShopSheet = false
    @State var showCreateOtherSheet = false
    @State var showSearchMealSheet = false

    // Partition events into several arrays of events by day
    init() {
        self.eventsByDay = partitionByDate(events: events)
    }

    var body: some View {
        
            NavigationView {
                ZStack(){
                    // list of days
                    VStack{
                        HStack{
                            Text("**Weekly Planner** August")
                                .font(.title2)
                                .padding()
                            Spacer()
                        }
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .leading, spacing: 30) {
                                
                                // create a row for each day
                                ForEach(eventsByDay, id: \.self) { day in
                                    WeekDayEntry(dayInfo: day, isMenuShown: $isMenuShown, showActionSheet: $showActionSheet, showCreateMealSheet: $showCreateMealSheet, showCreateShopSheet: $showCreateShopSheet, showCreateOtherSheet: $showCreateOtherSheet, showSearchMealSheet: $showSearchMealSheet)
                                }
                            }
                        }
                        .frame(minHeight: 300, alignment: .topLeading)
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
                    if isMenuShown {

                        RadialLayout {
                            Button {
                                isMenuShown.toggle() //Hides the buttons once pressed
                                showSearchMealSheet.toggle()
                            } label: {
                                Bubble(colour: Color("Color 1"), text: "Achive")
                            }
                            Button {
                                isMenuShown.toggle()
                                showCreateShopSheet.toggle()
                            } label: {
                                Bubble(colour: Color("Color 2"), text: "Shopping")
                            }
                            Button {
                                isMenuShown.toggle()
                                showCreateMealSheet.toggle()
                            } label: {
                                Bubble(colour: Color("Color 3"), text: "Meal")
                            }
                            Button {
                                isMenuShown.toggle()
                                showCreateOtherSheet.toggle()
                            } label: {
                                Bubble(colour: Color("Color 4"), text: "Other")
                            }
                        }
                    }
            }
            
            
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
