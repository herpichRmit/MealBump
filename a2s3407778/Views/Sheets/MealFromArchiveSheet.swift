//
//  MealFromArchiveSheet.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI


/// MealFromArchiveSheet returns a list of all meals stored within the ``EventCore`` CoreData storage.
/// Users can tap on an item to open ``NewMealSheet`` with existing data
struct MealFromArchiveSheet: View {
    
    @Environment(\.managedObjectContext) private var viewContext // For accessing CoreData
    @EnvironmentObject var settings: DateObservableObject // Global variables
    @Environment(\.dismiss) var dismiss // For closing the window
    @State private var searchText = ""
    
    @Binding var refreshTrigger : Bool
    
    // Fetch all past events of type meal
    @FetchRequest var pastMeals: FetchedResults<EventCore>
    
    
    init(refreshTrigger: Binding<Bool>){
        
        // init refresh trigger
        self._refreshTrigger = refreshTrigger
            
        // Sort alphabetically
        let orderSort = NSSortDescriptor(key: "name", ascending: true)
        
        // Constructing filter predicate
        let predicate = NSPredicate(format: "name != nil AND eventType = 'Meal'")
        
        // Underscore means we are changing the wrapper itsself rather than the value stored
        _pastMeals = FetchRequest<EventCore>(
            sortDescriptors: [orderSort],
            predicate: predicate)
    }
    
    var body: some View {
        NavigationStack{
            List {
                // List all previous meals
                ForEach(searchResults, id: \.self) { meal in
                    Button(meal.name ?? "") {
                        // On tap set current meal as the selectedEvent, close this sheet, and then open NewMealSheet with selectedEvent data
                        settings.selectedEvent = meal
                        dismiss()
                        
                        // Slight delay to preserve modal opening and closing animations
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            settings.showCreateMealSheet = true
                        }
                    }
                }
            }
            .navigationTitle("Meals")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Back", action: {
                settings.showSearchMealSheet = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    refreshTrigger.toggle()
                }
            }))
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for food...")
    }
    
    // Filters items in a List view, in conjunction with the '.searchable' modifier
    var searchResults: [EventCore] {
        let arrayPastMeals = pastMeals.map { $0 }
        
        if searchText.isEmpty {
            return arrayPastMeals
        } else {
            return arrayPastMeals.filter { $0.name?.contains(searchText) ?? false }
        }
    }
    
    

}

