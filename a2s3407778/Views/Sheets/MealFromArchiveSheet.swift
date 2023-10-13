//
//  MealFromArchiveSheet.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

struct MealFromArchiveSheet: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: DateObservableObject
    
    // fetch all past meals
    @FetchRequest(
        sortDescriptors: []
        //predicate: NSPredicate(format: "eventType == Meal")
    ) var pastMeals: FetchedResults<EventCore>
    
    @ObservedObject var viewModel = AutocompleteViewModel()
    let apiKey = "a6591f4c9d2346aabe241d5abe293dd4" // Add your API key here
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            List {
                // List all previous meals
                ForEach(searchResults, id: \.self) { meal in
                    Button(meal.name ?? "") {
                        // set meal as selected meal close this sheet, and then open NewMealSheet
                        settings.selectedEvent = meal
                        //settings.showSearchMealSheet = false
                        dismiss()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            settings.showCreateMealSheet = true
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Meals")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for food...")
    }
    

    var searchResults: [EventCore] {
        let arrayPastMeals = pastMeals.map { $0 }
        
        if searchText.isEmpty {
            return arrayPastMeals
        } else {
            return arrayPastMeals.filter { $0.name?.contains(searchText) ?? false }
        }
    }
    
    

}

