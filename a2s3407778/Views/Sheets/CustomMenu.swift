//
//  CustomView.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

struct CustomMenu: View {
    @EnvironmentObject var settings: DateObservableObject
    
    var body: some View {
        PlusButton()
            .onTapGesture(coordinateSpace: .global) { location in
                settings.animateActionMenu = true
                settings.activateSheetPosition = location

                // delay so animtion is applied
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    print("delay end")
                    settings.showActionMenu = true 
                }
            }
        
//    MARK: Create New Meal
            .sheet(isPresented: $settings.showCreateMealSheet) {
                NewMealSheet()
            }
        
//    MARK: Search archive of past meals
            .sheet(isPresented: $settings.showSearchMealSheet) {
                MealFromArchiveSheet()
            }
        
//    MARK: Create new shopping Trip
            .sheet(isPresented: $settings.showCreateShopSheet) {
                NewShoppingTripSheet()
                    .presentationDetents([.medium]) //Makes the sheet half height
                    .presentationDragIndicator(.visible)
            }
        
//    MARK: Create some other kind of event
            .sheet(isPresented: $settings.showCreateOtherSheet) {
                NewOtherEventSheet()
                    .presentationDetents([.medium]) //Makes the sheet half height
                    .presentationDragIndicator(.visible)
            }
        
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenu()
    }
}
