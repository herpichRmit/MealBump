//
//  DayView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 14/8/2023.
//
import Foundation
import CoreData
import SwiftUI

struct DayView: View {
    //    MARK: - Variables and FetchRequests
    
    // Date selected in the date picker
    @State var selectedDate: Date = Date() //Start with Today's Date
        
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData

    @State var isMenuShown = false
    @State var showActionSheet = false
    @State var showCreateMealSheet = false
    @State var showCreateShopSheet = false
    @State var showCreateOtherSheet = false
    @State var showSearchMealSheet = false
    
    //    MARK: - View Body
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Text("**Daily Planner** August") //The Double Star makes "Planner" Bold
                        .font(.title2)
                        .padding()
                    Spacer()
                    EditButton()
                    Button { //Plus Button adding new random item (for testing)
                        addRandomEventToToday()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                }
                
                DatePicker(selectedDate: $selectedDate)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                Spacer()
                
                Text("\(selectedDate.formatted(.dateTime.weekday(.wide).day().month().year()))").font(.callout)
                
                DayFilteredList(filter: selectedDate)
                
                HStack{
                    Spacer()
                                            SheetView(
//                                                dayInfo: $allEvents,
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
    
    
    //    MARK: - Helper Functions
    
    fileprivate func addRandomEventToToday(){
        // Creates 4 random events on today's date and saves to viewContext
        
        // Setting random information to use to create events
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
        let timePeriod = ["Snack","Breakfast", "Lunch", "Dinner", "", ""]
        let type = ["meal", "meal", "Shopping Trip", "Meal", "Meal"]
        
        // Picking random elements
        let chosenName = name.randomElement()! //Force Unwrap ok here because there will always be data
        let chosenNote = note.randomElement()!
        let chosenOrder = order.randomElement()!
        let chosenTimePeriod = timePeriod.randomElement()!
        let chosenType = type.randomElement()!
        
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        newEvent.date = selectedDate //Add events to the selected date
        newEvent.name = chosenName
        newEvent.note = chosenNote
        newEvent.order = Int16(chosenOrder)
        newEvent.timePeriod = chosenTimePeriod
        newEvent.type = chosenType
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }        }
    
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        // All this stuff is to allow the preview to work with coredata
//        let context = PersistenceController.preview.container.viewContext
//        let newLaunch = EventCore(context: context)
//        newLaunch.name = "Not sure what this is about here"
//        return DayView()
//    }
//}


