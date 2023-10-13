//
//  AnimationOverlay.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

struct AnimationOverlay: View {
    @EnvironmentObject var settings: DateObservableObject
    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        // Used to exit blur background and exit popup if tapped outside of buttons
        if settings.showActionMenu {
            VStack(alignment: .leading){
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .background(.regularMaterial)
            .opacity(0.9)
            .blur(radius: 10, opaque: false)
            .onTapGesture {
                settings.showActionMenu = false
            }
        }
        
        
        // When the plus button in DayEntry->sheetView is pressed, custom action sheet below is activated
        
        
        if settings.showActionMenu {
            
            // we want to build initial layout after button is pressed
            // then we want to switch instanly
            let layout = settings.showActionMenu ? AnyLayout(RadialLayout()) : AnyLayout(InitialLayout())
            
            layout {
                Bubble(colour: Color("Color 1"), text: "Archive", active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu.toggle() //Hides the buttons once pressed
                        settings.showSearchMealSheet.toggle()
                    }
                    .onAppear(){
                        print(settings.activateSheetPosition)
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color("Color 2"), text: "Shopping", active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu.toggle() //Hides the buttons once pressed
                        settings.showCreateShopSheet.toggle()
                    }
                    .onAppear(){
                        print(settings.activateSheetPosition)
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color("Color 3"), text: "Meal", active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu.toggle() //Hides the buttons once pressed
                        settings.showCreateMealSheet.toggle()
                        
                        // need to initalise a new eventCore
                        let event = EventCore(context: viewContext)
                        settings.selectedEvent = event
                        
                        
                    }
                    .onAppear(){
                        print("testB")
                        print(settings.activateSheetPosition)
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color("Color 4"), text: "Other", active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu.toggle() //Hides the buttons once pressed
                        settings.showCreateOtherSheet.toggle()
                    }
                    .onAppear(){
                        print("testB")
                        print(settings.activateSheetPosition)
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                
            }
            .animation(.easeInOut(duration: 0.2))
            
        }
    }
}

struct AnimationOverlay_Previews: PreviewProvider {
    static var previews: some View {
        AnimationOverlay()
    }
}
