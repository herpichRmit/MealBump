//
//  ShoppingView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI
import CoreData

/// One of the core App Views. The Shopping list view. Will display all shopping items in the coredata store, and provides option to show only unchecked items or all items.
struct ShoppingView: View {
    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch Request for ALL Items in the shopping list
    @FetchRequest(sortDescriptors: []) private var allShoppingItems: FetchedResults<ShoppingItemCore>
    
    // Fetch Request for only checked items in the shopping list, using predicates
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "checked == False") // Filter by checked or unchecked
    ) var checkedShoppingItems: FetchedResults<ShoppingItemCore>
    
    // State variable to show or hide the checked items in the list
    @State  var showCheckedInList = false
    
    // The environment variable which holds sheet activations and date
    @EnvironmentObject var settings: DateObservableObject
    
    var body: some View {
        
        VStack{
            
            // MARK: Heading, add and edit buttons
            
            HStack{
                Text("**Shopping List**") //The Double Star makes the text Bold
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                Button (action: {
                    removeAllShoppingItems()
                }, label: {
                    Text("Clear")
                })
                
                .padding()
                
                Button {
                    settings.showNewFoodSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $settings.showNewFoodSheet) {
                    NewFoodView()
                }
                .padding()
            }
            
            // MARK: List Logic
            
            let sectionHeadings = listAllTypes(allResults: allShoppingItems)
            
            
            List() {
                if (!sectionHeadings.isEmpty) { // Need this because ForEach loop will fail if no items in the sectionHeading array
                    
                    ForEach (0...sectionHeadings.count-1, id: \.self) { entry in //For Loop for each section and heading
                        
                        Section(header: Text("\(sectionHeadings[entry])")) { // Creating Section Headings based the array
                            
                            ForEach (showCheckedInList == false ? allShoppingItems : checkedShoppingItems) {  shoppingItem in // Shows or hides items based on checked parameter
                                
                                if (shoppingItem.category ?? "No Category" == sectionHeadings[entry]) { // Only displaying each shopping item under it's correct category
                                    HStack{
                                        //This is to change which SF symbol is shown depending on the checked bool value
                                        Image(systemName: Bool(shoppingItem.checked) ? "checkmark.square" : "square")
                                            .onTapGesture {
                                                shoppingItem.checked.toggle() //Toggles between true and false
                                            }
                                        Text(shoppingItem.name ?? "Unknown Name")
                                        Spacer()
                                        Text(shoppingItem.measure ?? "Unknown Measurement")
                                            .font(
                                                .body
                                                .italic()
                                            )// For section testing
                                    }
                                }
                            }
                            .onDelete(perform: deleteShoppingItem)
                        }
                    }
                } else {
                    Text("No Items in your shopping list")
                }
                
                showHideCheckedButton(showCheckedInList: $showCheckedInList) // Condensed this logic down to another struct at bottom of file
            }
        }
        .headerProminence(.increased)
        .listStyle(.plain)
    }
    
    
    // MARK: Supporting Methods
    
    /// Function checks all items in the shopping list and creates an array of all the categories these items have, purpose is to dynamically generate only the headings needed in the shopping list and prevent headings with no items underneath
    func listAllTypes(allResults: FetchedResults<ShoppingItemCore>) -> [String] {
        var listOfCategories: [String] = []
        
        for item in allResults {
            if (!listOfCategories.contains(item.category ?? "No Category") ) { //If the array doesn't contain whatever category listed in coredata item
                listOfCategories.append(item.category ?? "No Category") // Add category to the array
            }
        }
        return listOfCategories
    }
    /// Function for adding random items to the shopping list, was used for testing and not used in release version of app
    func addRandomItem(){
        let name = ["Prunes", "Pasta", "Beef", "Chicken", "Hummus", "Chilli", "Olive Oil", "Milk", "Bread", "Rice", "Ice Cream", "Washing Liquid", "Lemons", "Oranges", "Bananas", "Ginger Beer"]
        let checked = [true, false]
        let measure = ["cup", "dash","250g", "packet"]
        let category = ["Grocer", "Aldi", "Coles", "Bucher"]
        
        let chosenName = name.randomElement()!
        let chosenChecked = checked.randomElement()!
        let chosenMeasure = measure.randomElement()!
        let chosenCategory = category.randomElement()!
        
        let newShoppingItem = ShoppingItemCore(context: viewContext)
        newShoppingItem.name = chosenName
        newShoppingItem.measure = chosenMeasure
        newShoppingItem.category = chosenCategory
        newShoppingItem.checked = chosenChecked
        
        saveData()
    }
    
    /// Function for deleting a shoppingItem in coreData
    func deleteShoppingItem(at offsets: IndexSet) {
        for offset in offsets{ //Loop over all of the offsets that we are given
            let itemToDelete = allShoppingItems[offset] //Find the item in the array? I think
            viewContext.delete(itemToDelete) //Deleting the the item from the array
        }
        saveData()
    }
    
    /// Function for removing all items on the shopping list or clearing the shopping list
    func removeAllShoppingItems(){
        
        for shoppingItem in allShoppingItems {
            viewContext.delete(shoppingItem)
        }
        saveData()
    }
    
    /// Function to save data from Managed Object Context to persistant store
    func saveData(){
        do {
            try viewContext.save() //Saving data to the persistent store
        } catch {
            let nserror = error as NSError
            fatalError("Saving Error: \(nserror), \(nserror.userInfo)")
        }    }
    
}
 /// View which creates a button to show or hide the checked items in the shopping list. Button will change it's text label to reflect what change it will make
struct showHideCheckedButton: View {
    
    @Binding var showCheckedInList: Bool
    
    var body: some View {
        HStack(){ // Show Items button logic and formatting
            Spacer()
            Button {
                showCheckedInList.toggle()
            } label: {
                if (showCheckedInList) {
                    Text("Show All Items")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                } else {
                    Text("Hide Checked Items")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            Spacer()
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
