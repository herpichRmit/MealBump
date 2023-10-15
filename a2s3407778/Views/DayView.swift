//
//  DayView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 14/8/2023.
//
import Foundation
import CoreData
import SwiftUI

/// Main Daily Planner View in app
struct DayView: View {
    //    MARK: - Variables
    @EnvironmentObject var settings: DateObservableObject
    
    // For accessing CoreData
    @Environment(\.managedObjectContext) private var viewContext
    
    // DateFormatter for making headings in view
    let dateFormatter = DateFormatter()
    
    //    MARK: - View Body
    
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("**Daily Planner** \(dateFormatter.string(from: settings.selectedDate) )")
                    .font(.title2)
                    .padding()
                    .onAppear(){
                        dateFormatter.dateFormat = "MMMM"
                    }
                
                Spacer()
                
                EditButton()
                
                .padding()
            }
            
            CustomDatePicker()
                .padding(.horizontal)
                .padding(.bottom, 30)
            
            Spacer()
            
            // Full Date subheading
            Text("\(settings.selectedDate.formatted(.dateTime.weekday(.wide).day().month().year()))").font(.callout)
            
            //Must pass the date from here to the DayFilteredList's init(), because we need to know the date first in order to construct the fetch request inside DayFilteredList()
            DayFilteredList(filter: settings.selectedDate)
            
        }
    }
    
    
    //    MARK: - Helper Functions
    
    /// Function for creating random events for testing. No Longer Used in deployed app
    func addRandomEventToToday(){
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
        let chosenEventType = EventType.Meal.rawValue
        
        var chosenMealKind = ""
        if (chosenEventType == "Meal") { //If the event if a MEAL then assign a meal kind
            chosenMealKind = EventMealKind.allCases.randomElement()!.rawValue // Choosing random from ENUM
        }
        
        // Adding data to new EventCore Object
        let newEvent = EventCore(context: viewContext) //New object with the CoreData ViewContext
        newEvent.date = settings.selectedDate //Add events to the selected date
        newEvent.name = chosenName
        newEvent.note = chosenNote
        newEvent.order = Int16(100)
        newEvent.mealKind = chosenMealKind
        newEvent.eventType = chosenEventType
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

