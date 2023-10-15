//
//  ContentView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 7/8/2023.
//

import SwiftUI

/// Base View which contains the TabView for switching between the 3 Main views: ShoppingView, DayView, WeekPlannerView
struct ContentView: View {
    
    @EnvironmentObject var settings: DateObservableObject
    
    // The following is all required to send data to the widget
    // These array is used to map results from the FetchRequest
    @State var summaryEvents : [String] = []
    @State var summaryItems : [String] = []
    @FetchRequest var events: FetchedResults<EventCore>
    @FetchRequest var shoppingItems: FetchedResults<ShoppingItemCore>
    
    init(){
        // Constructing sort descriptor
        let orderSort = NSSortDescriptor(key: "order", ascending: true)
        
        // Constructing filter predicate
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: .now)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@ AND name != nil", start as NSDate, end! as NSDate)
        
        // Underscore means we are changing the wrapper itsself rather than the value stored
        _events = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
        _shoppingItems = FetchRequest<ShoppingItemCore>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "checked == False"))
    }
    
    
    var body: some View {
        ZStack{
            TabView(selection: $settings.openTab){
                ShoppingView()
                    .tabItem(){
                        Image(systemName: "cart")
                        Text("Shopping List")
                    }
                    .tag("shoppinglist")
                    .onAppear(){
                        settings.openTab = "shoppinglist"
                    }
                DayView()
                    .tabItem(){
                        Image(systemName: "sun.min")
                        Text("Daily")
                    }
                    .tag("daily")
                    .onAppear(){
                        settings.openTab = "daily"
                    }
                WeekPlannerView()
                    .tabItem(){
                        Image(systemName: "clock")
                        Text("Weekly")
                    }
                    .tag("weekly")
                    .onAppear(){
                        settings.openTab = "weekly"
                    }
            }
            .onAppear {
                // correct the transparency bug for Tab bars
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                // correct the transparency bug for Navigation bars
//                let navigationBarAppearance = UINavigationBarAppearance()
//                navigationBarAppearance.configureWithOpaqueBackground()
//                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                
                sendSummaryToWidget()
            }
            // When the plus button in WeekDayEntry is pressed, the menu animation and menu is shown as an overlay to the screen.
            AnimationOverlay()
        }
        
    }
    
    /// Function to convert `events` and `shoppingItems` fetchedResult sets to a `DaySummary` struct, which is then saved to UserDefaults for widget to access.
    func sendSummaryToWidget() {
        
        /* Events */
        // Ideally get the first four results
        var count = 0...3
        
        // Unless there is less than four results availble, then get all results
        if events.endIndex == 0 {
            count = 0...0
        } else if events.endIndex < 4 {
            count = 0...events.endIndex - 1
        }
        
        if count == 0...0 {
            summaryEvents = []
        } else {
            // Create shopping item summary
            for i in count {
                summaryEvents.append(events[i].name ?? "Save failed")
            }
        }
        
        /* Shopping items */
        // Ideally get the first four results
        count = 0...3

        // Unless there is less than four results availble, then get all results
        if shoppingItems.endIndex == 0 {
            count = 0...0
        } else if shoppingItems.endIndex < 4 {
            count = 0...shoppingItems.endIndex - 1
        }
        
        if count == 0...0 {
            summaryItems = []
        } else {
            // Create shopping item summary
            for i in count {
                summaryItems.append(shoppingItems[i].name ?? "Save failed")
            }
        }
        
        /* Summary */
        let summary = DaySummary(eventNames: summaryEvents, shoppingItems: summaryItems)
        
        // Convert summary to JSON using JSONEncoder
        let summaryData = try! JSONEncoder().encode(summary)
        
        // ... and store it in shared UserDefaults container for widget to access
        UserDefaults(suiteName:"group.com.charlieblyton.a2s3407778")!.set(summaryData, forKey: "summary")
    }
    
}


/// Small data structure that can be turned into JSON.
struct DaySummary : Codable {
    var eventNames : [String]
    var shoppingItems : [String]
}


/// Struct to enable Canvas/Live Preview for this view
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


