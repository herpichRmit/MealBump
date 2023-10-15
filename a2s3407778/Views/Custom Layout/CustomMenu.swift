//
//  CustomView.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

/// View which is used to display the CustomMenu of buttons and as a place to activate sheets for modifying data
/// Contains custom button and sheets. Note that the menu itself is not encapsulated in this, instead it is contained in the `AnimationOverlay` view.
struct CustomMenu: View {
    @EnvironmentObject var settings: DateObservableObject
    @State private var isPressed = false
    
    @Binding var refreshTrigger : Bool
    
    var body: some View {
        PlusButton()
            .opacity(isPressed ? 0.4 : 1.0)
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .onTapGesture(coordinateSpace: .global) { location in
                settings.animateActionMenu = true
                settings.activateSheetPosition = location
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    refreshTrigger.toggle()
                }
                
                // delay so animtion is applied
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    settings.showActionMenu = true
                }
            }
            .pressEvents {
                withAnimation(.easeIn(duration: 0.1)) {
                    isPressed = true
                }
            } onRelease: {
                withAnimation {
                    isPressed = false
                }
            }
            
//    MARK: Create New Meal
            .sheet(isPresented: $settings.showCreateMealSheet) {
                NewMealSheet(refreshTrigger : $refreshTrigger)
            }
        
//    MARK: Search archive of past meals
            .sheet(isPresented: $settings.showSearchMealSheet) {
                MealFromArchiveSheet(refreshTrigger : $refreshTrigger)
            }
        
//    MARK: Create new shopping Trip
            .sheet(isPresented: $settings.showCreateShopSheet) {
                NewShoppingTripSheet(refreshTrigger : $refreshTrigger)
                    .presentationDetents([.medium]) //Makes the sheet half height
                    .presentationDragIndicator(.visible)
            }
        
//    MARK: Create some other kind of event
            .sheet(isPresented: $settings.showCreateOtherSheet) {
                NewOtherEventSheet(refreshTrigger : $refreshTrigger)
                    .presentationDetents([.medium]) //Makes the sheet half height
                    .presentationDragIndicator(.visible)
            }
        
    }
}
