//
//  SearchFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI
import Combine

//represent a post
struct Food: Codable {
    let name: String
    let image: String
    let id: Int
    let aisle: String
    let possibleUnits: [String]
}

// The ObservableObject is a protocol provided by SwiftUI's Combine framework
class AutocompleteViewModel: ObservableObject {
    
    // this property is published and watched by the content view
    // when data is changed here it will automatically be updated in the view.
    // this property is updated from an asynchronous method running on a background thread.
    @Published var autocompleteData: [Food] = []
    
    // represents the subscription to a service
    private var cancellables = Set<AnyCancellable>()
    
    func fetchAutocomplete(keyword: String, apiKey: String) {
        let url = URL(string: "https://api.spoonacular.com/food/ingredients/autocomplete?apiKey=\(apiKey)&query=\(keyword)&number=6&metaInformation=true")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Food].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Weather data fetching error: \(error)")
                }
            }, receiveValue: { data in
                self.autocompleteData = data
            })
            .store(in: &cancellables)
        
    }
    
    func cancelSubscription() {
            // Cancel all the subscriptions stored in cancellables
            cancellables.forEach { $0.cancel() }
        }
}



struct SearchFoodView: View {
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: DateObservableObject
    
    @ObservedObject var viewModel = AutocompleteViewModel()
    let apiKey = "a6591f4c9d2346aabe241d5abe293dd4" // Add your API key here
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack{
                List() {
                    ForEach(viewModel.autocompleteData, id: \.id) { item in
                        NavigationLink(destination: NewFoodView(name: item.name, note: item.possibleUnits[0], category: .None)) {
                            Text(item.name)
                        }
                    }
                    NavigationLink(destination: NewFoodView(name: searchText)) {
                        searchText != "" ? Text("Add as \(searchText)").foregroundColor(.blue) : Text("Add as new item").foregroundColor(.blue)
                    }
                }
            }
            
        }
        .navigationTitle("Food")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // When the list appears ask the view model to fetch the data
            viewModel.fetchAutocomplete(keyword: searchText, apiKey: apiKey)
        }
        .onDisappear {
            viewModel.cancelSubscription() // Call a method to cancel the subscription
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for food...")
        .onChange(of: searchText) { newValue in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.fetchAutocomplete(keyword: searchText, apiKey: apiKey)
            }
        }
    }

}
    
