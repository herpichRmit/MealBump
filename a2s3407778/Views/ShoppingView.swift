//
//  ShoppingView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI

struct ShoppingView: View {
    
    // Loading the shopping list
    //      var shoppingList: [ShoppingItem] = ShoppingItem.allShoppingItems
    //     var displayedList: [ShoppingItem]

    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) var moc

    // Fetch Request for ALL Items in the shopping list
    @FetchRequest(sortDescriptors: []) var allShoppingItems: FetchedResults<ShoppingItemCore>
    
    // Fetch Request for only checked items in the shopping list, using predicates
    @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "checked == True")
    ) var checkedShoppingItems: FetchedResults<ShoppingItemCore>

    // State variable to show or hide the checked items in the list
    @State  var showCheckedInList = false
    
    var body: some View {
        VStack{
            HStack{
                Text("**Shopping List**") //The Double Star makes the text Bold
                    .font(.title2)
                    .padding()
                Spacer()
                Button { //Plus Button adding new random item (for testing)
                    addRandomItem()
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
            }
            
            NavigationView {
                List () {
                    // Using Ternary operator here instead of if statement
                    ForEach (showCheckedInList == true ? allShoppingItems : checkedShoppingItems) {  shoppingItem in
                        HStack{
                            //This is to change which SF symbol is shown depending on the checked bool value
                            Image(systemName: Bool(shoppingItem.checked) ? "checkmark.square" : "square")
                                .onTapGesture {
                                    shoppingItem.checked.toggle() //Toggles between true and false
                                }
                            Text(shoppingItem.name ?? "Unknown")
                        }
                    }
                    .onDelete(perform: deleteShoppingItem) //Adds the swipe to delete function to the list, you need to add it to the forEach loop for some reason
                    
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
                .listStyle(.plain)
            }
        }
    }
    
    // Method for adding random items to the shopping list for testing
    func addRandomItem(){
        let name = ["Prunes", "Pasta", "Beef", "Chicken", "Hummus", "Chilli", "Olive Oil", "Milk", "Bread", "Rice", "Ice Cream", "Washing Liquid", "Lemons", "Oranges", "Bananas", "Ginger Beer"]
        let checked = [true, false]
        let measure = ["cup", "dash","250g", "packet"]
        let category = ["Grocer", "Aldi", "Coles", "Bucher"]
        
        let chosenName = name.randomElement()!
        let chosenChecked = checked.randomElement()!
        let chosenMeasure = measure.randomElement()!
        let chosenCategory = category.randomElement()!
        
        let newShoppingItem = ShoppingItemCore(context: moc)
        newShoppingItem.name = chosenName
        newShoppingItem.measure = chosenMeasure
        newShoppingItem.category = chosenCategory
        newShoppingItem.checked = chosenChecked
        
        try? moc.save()
    }
    
    //Method for deleting shoppingItem in coreData
    func deleteShoppingItem(at offsets: IndexSet) {
        for offset in offsets{ //Loop over all of the offsets that we are given
            let itemToDelete = allShoppingItems[offset] //Find the item in the array? I think
            moc.delete(itemToDelete) //Deleting the the item from the array
        }
        try? moc.save() //Save the data to CoreData, if you don't have this it won't stay the same upon restarting the app
            }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
