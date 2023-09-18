//
//  ShoppingView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI

struct ShoppingView: View {
    
    // Loading the shopping list
    @State  var shoppingList: [ShoppingItem] = ShoppingItem.allShoppingItems
    @State  var displayedList: [ShoppingItem] = ShoppingItem.allShoppingItems
    @State  var showCheckedInList = false

    
    var body: some View {
        VStack{
            HStack{
                Text("**Shopping List**") //The Double Star makes "Planner" Bold
                    .font(.title2)
                    .padding()
                Spacer()
            }
            
            ZStack{
                

                
                List () {
                    ForEach ($displayedList) {  $shoppingItem in
                        HStack{
                            //This is to change which SF symbol is shown depending on the checked bool value
                            Image(systemName: shoppingItem.checked ? "checkmark.square" : "square")
                                .onTapGesture {
                                    shoppingItem.checked.toggle() //Toggles between true and false
                                }
                            Text(shoppingItem.title)
                        }
                    }
                    HStack(){ // Show Items button logic and formatting
                        Spacer()
                        Button {
                            showCheckedInList.toggle()
                            filterList()
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
    func filterList() {
        if !showCheckedInList {
            displayedList = shoppingList
        } else {
            displayedList = shoppingList.filter { shopItem in
                if shopItem.checked {
                    return true
                } else {
                    return false
                }
            }
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
