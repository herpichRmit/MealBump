//
//  SearchFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

struct SearchFoodView: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    
    // Fetch Request for ALL Items in the shopping list
    @FetchRequest(sortDescriptors: []) private var allShoppingItems: FetchedResults<ShoppingItemCore>
    @EnvironmentObject var settings: DateObservableObject
    
    let testFoods = ["testFish","Ground beef","Butter","Milk","Potato"]
    
    //@Binding var foodItems: [[String]]
    //@Binding var allFoodItems: [[String]]
    
    //@Binding var showNestedView: Bool
    
    //
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    //ForEach(allFoodItems, id: \.self) { item in
                    //    NavigationLink(destination: EditFoodView(currentItem: item, foodItems: $foodItems)) {
                    //        Text(item[0])
                    //    }
                        
                    }
//                    NavigationLink(destination: EditFoodView(foodItems: $foodItems)){ // TODO: change to new food
//                        Text("Add new food") //action: addFood
//                            .foregroundColor(.blue)
//                    }
                    
                }
                .onAppear(){
                    //self.removeItemsAlreadyUsed()
                }
                .navigationTitle("Food")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }

    
    func removeItemsAlreadyUsed() {
        // cycle through foodItems and remove instance from allFoodItems
        // later will be replaced by better database quering
        //for item in $foodItems {
        //    if let temp = allFoodItems.firstIndex(of: item.wrappedValue) {
        //        allFoodItems.remove(at: temp)
        //    }
    }
            
        
        
}
    

/*
struct SearchFoodView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodView()
    }
}
*/
