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

    // You don't initialise an environment object as it has already been initialized in ContentView()
    // I just named it settings to have a unique name so we don't get confused, but the name is local to this view. It can be anything...
    @EnvironmentObject var settings: DateObservableObject
            
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData
    
//
//    @State var isMenuShown = false
//    @State var showActionSheet = false
//    @State var showCreateMealSheet = false
//    @State var showCreateShopSheet = false
//    @State var showCreateOtherSheet = false
//    @State var showSearchMealSheet = false
    
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
                
                DatePicker()
//                    .environmentObject(settings)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                Spacer()
                
                Text("\(settings.selectedDate.formatted(.dateTime.weekday(.wide).day().month().year()))").font(.callout)
                
                //Must pass the date from here to the DayFilteredList's init(), because we need to know the date first in order to construct the fetch request inside DayFilteredList()
                DayFilteredList(filter: settings.selectedDate)
                
                CustomMenu()
                
                
            }
        }
        
        AnimationOverlay()
        
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
        
        // Picking random elements
        let chosenName = name.randomElement()! //Force Unwrap ok here because there will always be data
        let chosenNote = note.randomElement()!
        
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        newEvent.date = settings.selectedDate //Add events to the selected date
        newEvent.name = chosenName
        newEvent.note = chosenNote
        newEvent.order = Int16(100)
        newEvent.mealKind = EventMealKind.allCases.randomElement()?.rawValue
        newEvent.eventType = EventType.allCases.randomElement()?.rawValue
        newEvent.archived = false
        
        // Saving data
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
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


