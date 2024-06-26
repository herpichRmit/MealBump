//
//  SearchFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI
import Combine

/// Data structure to represent the format being accessed from the api
struct Food: Codable  {
    let name: String
    let image: String
    let id: Int
    let aisle: String
    let possibleUnits: [String]
}


/// This view-model recieves data from the Spoonacular API and automatically updates the `SearchFoodView` view.
class AutocompleteViewModel: ObservableObject {
    // This property is published and watched by the content view.
    // When data is changed here it will automatically be updated in the view.
    // This property is updated from an asynchronous method running on a background thread.
    @Published var autocompleteData: [Food] = []
    
    var isSuccessful: Bool!
    
    // represents the subscription to a service
    private var cancellables = Set<AnyCancellable>()
    
    // Sends GET request to api based on keyword input
    func fetchAutocomplete(keyword: String, apiKey: String, completion: @escaping (Bool) -> Void) {
        let keyword = keyword.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://api.spoonacular.com/food/ingredients/autocomplete?apiKey=\(apiKey)&query=\(keyword)&number=1&metaInformation=true")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Food].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Autocomplete data fetching error: \(error)")
                }
            }, receiveValue: { data in
                self.autocompleteData = data
                completion(self.isSuccessful)
            })
            .store(in: &cancellables)
        
    }
    
    /// Cancels api listeners when no longer needed
    func cancelSubscription() {
            // Cancel all the subscriptions stored in cancellables
            cancellables.forEach { $0.cancel() }
        }
}


/// This view takes a user input via the `.searchable` modifier and recieves autocomplete food data from the api. The user then selects an response to use as inputs in `NewFoodView`
struct SearchFoodView: View {
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: DateObservableObject
    
    @ObservedObject var viewModel = AutocompleteViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack{
                List() {
                    // List food entries from response
                    ForEach(viewModel.autocompleteData, id: \.id) { item in
                        NavigationLink(destination: NewFoodView(name: item.name, note: item.possibleUnits[0], category: ShopItemCategory(rawValue: item.aisle) ?? .None )) {
                            Text(item.name)
                        }
                    }
                    // Provide button to add a food item not using details from this list
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
            viewModel.isSuccessful = true
            viewModel.fetchAutocomplete(keyword: searchText, apiKey: apiKey){ _ in
            }
        }
        .onDisappear {
            viewModel.cancelSubscription() // Call a method to cancel the subscription
        }
        // As user input changes make more calls to the database
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for food...")
        .onChange(of: searchText) { newValue in
            viewModel.isSuccessful = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.fetchAutocomplete(keyword: searchText, apiKey: apiKey){ _ in }
            }
        }
    }
    
    
    // Reference
    // Friese P (2020) Fetching API Keys from Property List Files, Peter Freise Personal Website, accessed 11 October 2023. https://peterfriese.dev/posts/reading-api-keys-from-plist-files/
    
    private var apiKey: String {
          get {
              guard let filePath = Bundle.main.path(forResource: "SpoonacularAPI-Secret", ofType: "plist") else {
                  fatalError("Couldn't find file 'SpoonacularAPI-Secret'.")
              }
              let plist = NSDictionary(contentsOfFile: filePath)
              guard let value = plist?.object(forKey: "API_KEY") as? String else {
                  fatalError("Couldn't find key 'API_KEY' in 'SpoonacularAPI-Info.plist'.")
              }
              if (value.starts(with: "_")) {
                  fatalError("Please replace API_KEY with key from spoonacular.com")
              }
        return value
      }
    }

}



    
