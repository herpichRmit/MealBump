//
//  DayView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 14/8/2023.
//
import CoreData
import SwiftUI

//func hardcodeDate() -> Date {
//    // Hardcoding the default date to be 7th August where our dummy data is
//
//    let formatter = DateFormatter()
//    formatter.dateFormat = "YYYY-MM-dd"
//    let anchor = formatter.date(from: "2023-08-07") ?? Date()
//    return anchor
//}


struct DayView: View {
    
    // Date selected in the date picker
    @State var selectedDate: Date = Date() //Start with Today's Date
    
    @Environment(\.managedObjectContext) var moc //This is for saving data
    
    //This is for retreiving saved data, sorting by date
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "date == selectedDate")
    ) var todaysEvents: FetchedResults<EventCore>


    
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
                        //                        todaysEvents = FetchTodaysEvents(dateRequested: selectedDate)
                    }
                
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                
                Spacer()
                Text("\(selectedDate.formatted(.dateTime.weekday(.wide).day().month().year()))").font(.callout)
                
                
                List { // MARK: - Tile Scroll View
                    ForEach (todaysEvents) { event in
                        DayEventTile(
                            title: (event.name ?? "Unknown"),
                            note: (event.note ?? "Unknown"),
                            eventType: (event.timePeriod ?? "Unknown"))
                        .padding(.horizontal, 16.0)
                        .patical, 4.0)
                    }
                    HStack{
                        Spacer()
                        //                        SheetView(
                        //                            dayInfo: $allEvents,
                        //                            isMenuShown: $isMenuShown,
                        //                            showActionSheet: $showActionSheet,
                        //                            showCreateMealSheet: $showCreateMealSheet,
                        //                            showCreateShopSheet: $showCreateShopSheet,
                        //                            showCreateOtherSheet: $showCreateOtherSheet,
                        //                            showSearchMealSheet: $showSearchMealSheet
                        //                        )
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
    func addRandomEventsToToday(){
        // Creates 4 random events on today's date and saves to moc
        
        let name = ["Eggs Benedict",
                    "Grilled Chicken Salad",
                    "Spaghetti Bolognese",
                    "Fruit Yogurt Parfait",
                    "Oatmeal with Berries",
                    "Caprese Panini",
                    "Baked Salmon",
                    "Trail Mix"]
        let note = ["Enjoy for breakfast to kickstart the day.",
                    "Have for lunch to stay energized.",
                    "Dinner option for a satisfying evening meal.",
                    "Enjoy as a mid-morning snack."]
        let order = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let timePeriod = ["Snack","Breakfast", "Lunch", "Dinnner", "", ""] //Some events have nil values here
        let type = ["meal", "meal", "Shopping Trip", "Meal", "Meal"] //Multiple meals because there are most likely more meals than shopping trips
        
        for _ in 1...4 { // Looping 4 times
            
            let chosenName = name.randomElement()! //Force Unwrap ok here because there will always be data
            // Date doesn't change so don't need date here
            let chosenNote = note.randomElement()!
            let chosenOrder = order.randomElement()!
            let chosenTimePeriod = timePeriod.randomElement()!
            let chosenType = type.randomElement()!
            
            let newEvent = EventCore(context: moc)
            newEvent.date = Date() //Today's date
            newEvent.name = chosenName
            newEvent.note = chosenNote
            newEvent.order = Int16(chosenOrder)
            newEvent.timePeriod = chosenTimePeriod
            newEvent.type = chosenType
            
            try? moc.save()
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}


