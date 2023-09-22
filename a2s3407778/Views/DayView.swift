//
//  DayView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 14/8/2023.
//

import SwiftUI

struct DayView: View {
    
    // Date selected in the date picker
    @State var selectedDate: Date = hardcodeDate()
    
    // All of the events read from the json file into an Event Array
//    @State var events: [Event] = Event.allEvents
    
    // An event array for today's events, Start with today
    @State var todaysEvents: [Event] = FetchTodaysEvents(dateRequested: hardcodeDate())
    
    @State var isMenuShown = false
    @State var showActionSheet = false
    @State var showCreateMealSheet = false
    @State var showCreateShopSheet = false
    @State var showCreateOtherSheet = false
    @State var showSearchMealSheet = false
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Text("**Daily Planner** August") //The Double Star makes "Planner" Bold
                        .font(.title2)
                        .padding()
                    Spacer()
                }
                
                DatePicker(selectedDate: $selectedDate)
                    .onChange(of: selectedDate){ newValue in
                        todaysEvents = FetchTodaysEvents(dateRequested: selectedDate)
                    }
                
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                
                Spacer()
                Text("\(selectedDate.formatted(.dateTime.weekday(.wide).day().month().year()))").font(.callout)
                
                
                List { // MARK: - Tile Scroll View
                    ForEach (todaysEvents) { event in
                        EventTile(
                            title: event.title,
                            note: event.desc,
                            eventType: event.timeLabel)
                        .padding(.horizontal, 16.0)
                        .padding(.vertical, 4.0)
                    }
                    HStack{
                        Spacer()
                        SheetView(
                            events: $todaysEvents,
                            isMenuShown: $isMenuShown,
                            showActionSheet: $showActionSheet,
                            showCreateMealSheet: $showCreateMealSheet,
                            showCreateShopSheet: $showCreateShopSheet,
                            showCreateOtherSheet: $showCreateOtherSheet,
                            showSearchMealSheet: $showSearchMealSheet
                        )
                        Spacer()
                    }
                }
                
                .listStyle(.plain)
                .listRowSeparator(.hidden)
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
            
            // Custom action sheet
            // when plus button is pressed, custom action sheet is activated
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



func hardcodeDate() -> Date {
    // Hardcoding the default date to be 7th August where our dummy data is
    
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    let anchor = formatter.date(from: "2023-08-07") ?? Date()
    return anchor
}



func FetchTodaysEvents(dateRequested: Date) -> [Event] {
    
    let allData: [Event] = Bundle.main.decode(file: "TestData") //Getting all the data
    var todaysData: [Event] = []  //Initialising an empy array
    
    // Creating a date formatter that extracts a string of the date from the date object
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    let dateString: String = dateFormatter.string(from: dateRequested)
    
    
    for event in allData { //Loop to only get events from today
        //Comparing String to string as comparing entire date object will not find match
        if (dateFormatter.string(from: event.date) == dateString){
            todaysData.append(event)
        }
    }
    return todaysData
}

struct EventTile: View {
    
    var title: String
    var note: String?
    var eventType: String?
    var icon: String?
    
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading) {
                
                if let icon = icon {
                    Text("\(title)  \(Image(systemName: icon))")
                        .font(.system(.headline))
                } else {
                    Text(title)
                        .font(.system(.headline))
                }
                
                if let note = note {
                    Spacer()
                    
                    Text(note)
                        .font(.footnote)
                    Spacer()
                    
                }
                
                if let eventType = eventType {
                    Text(eventType)
                        .font(.bold(.subheadline)())
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            
            Spacer()
            
            VStack{
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .padding(20)
                Spacer()
            }
        }
        .onAppear(){
            //            DateStringConverter()
        }
        .compositingGroup()
        .background(Color.white.shadow(color: .black.opacity(0.3), radius: 3, x: 2, y: 2))
        .border(.gray)
    }
}



//func DateStringConverter(dateToConvert: Date) -> String {
//    var dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "YYYY-MM-dd"
//    var timeString = dateFormatter.string(from: Date())
//    return timeString
//}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}


