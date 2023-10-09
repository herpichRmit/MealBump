//
//  SearchFoodView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

struct SearchFoodView: View {
    
    let testFoods = ["testFish","Ground beef","Butter","Milk","Potato"]
    
    @Binding var foodItems: [[String]]
    @Binding var allFoodItems: [[String]]
    
    //@Binding var showNestedView: Bool
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section(){
                    ForEach(allFoodItems, id: \.self) { item in
                        NavigationLink(destination: EditFoodView(currentItem: item, foodItems: $foodItems)) { //showNestedView: $showNestedView
                            Text(item[0])
                        } //.isDetailLink(false)
                        
                    }
//                    NavigationLink(destination: EditFoodView(foodItems: $foodItems)){ // TODO: change to new food
//                        Text("Add new food") //action: addFood
//                            .foregroundColor(.blue)
//                    }
                    
                }
                .onAppear(){
                    self.removeItemsAlreadyUsed()
                }
                .navigationTitle("Food")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
    
    func removeItemsAlreadyUsed() {
        // cycle through foodItems and remove instance from allFoodItems
        // later will be replaced by better database quering
        for item in $foodItems {
            if let temp = allFoodItems.firstIndex(of: item.wrappedValue) {
                allFoodItems.remove(at: temp)
            }
        }
            
        
        
    }
    
}
/*
struct SearchFoodView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodView()
    }
}
*/
