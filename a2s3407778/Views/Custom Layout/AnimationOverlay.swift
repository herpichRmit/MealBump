//
//  AnimationOverlay.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI


/// Contains a pop-up menu designed to sit on top of all content. 
struct AnimationOverlay: View {
    
    // Published vairables accessible through environment
    @EnvironmentObject var settings: DateObservableObject
    
    // Managed Object Context to read the coredata objects
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isPressed = false
    @State private var backgroundAnimation = false
    
    var body: some View {
        
        // Used to exit blur background and exit popup if tapped outside of buttons
        if settings.animateActionMenu {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .onAppear(){
                withAnimation(.easeIn(duration: 0.2)) {
                    backgroundAnimation = true
                }
            }
            .background(.regularMaterial)
            .opacity(backgroundAnimation ? 0.2 : 0 )
            .blur(radius: backgroundAnimation ? 10 : 0, opaque: false)
            .onTapGesture {
                settings.showActionMenu = false
                
                // delay so animtion is applied
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    settings.animateActionMenu = false
                }
            }
        }
        
        // When the plus button in WeekDayEntry or DayView is pressed, custom action sheet below is activated
        if settings.animateActionMenu {
            // we want to build initial layout after button is pressed
            // then we want to switch instanly
            let layout = settings.showActionMenu ? AnyLayout(RadialLayout()) : AnyLayout(InitialLayout())
            
            layout {
                Bubble(colour: Color(.black), text: "folder.fill" /*"Archive"*/, active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu = false
                        settings.animateActionMenu = false
                        settings.showSearchMealSheet = true
                    }
                    .opacity(isPressed ? 0.8 : 1.0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .pressEvents {
                        withAnimation(.easeIn(duration: 0.05)) {
                            isPressed = true
                        }
                    } onRelease: {
                        withAnimation {
                            isPressed = false
                        }
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color(.black), text: "cart.fill" /*"Shopping"*/, active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu = false
                        settings.animateActionMenu = false
                        settings.showCreateShopSheet = true
                    }
                    .opacity(isPressed ? 0.8 : 1.0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .pressEvents {
                        withAnimation(.easeIn(duration: 0.05)) {
                            isPressed = true
                        }
                    } onRelease: {
                        withAnimation {
                            isPressed = false
                        }
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color(.black), text: "fork.knife" /*"Meal"*/, active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu = false
                        settings.animateActionMenu = false
                        settings.showCreateMealSheet = true
                        
                        // need to initalise a new eventCore
                        let event = EventCore(context: viewContext)
                        settings.selectedEvent = event
                    }
                    .opacity(isPressed ? 0.8 : 1.0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .pressEvents {
                        withAnimation(.easeIn(duration: 0.05)) {
                            isPressed = true
                        }
                    } onRelease: {
                        withAnimation {
                            isPressed = false
                        }
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
                Bubble(colour: Color(.black), text: "questionmark.folder.fill" /*"Other"*/, active: settings.showActionMenu)
                    .onTapGesture{
                        settings.showActionMenu = false
                        settings.animateActionMenu = false
                        settings.showCreateOtherSheet = true
                    }
                    .opacity(isPressed ? 0.8 : 1.0)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .pressEvents {
                        withAnimation(.easeIn(duration: 0.05)) {
                            isPressed = true
                        }
                    } onRelease: {
                        withAnimation {
                            isPressed = false
                        }
                    }
                    .layoutValue(key: StartPosition.self, value: settings.activateSheetPosition)
            }
            .animation(.easeInOut(duration: 0.15))
        }
    }
}

/// Struct to enable Canvas/Live Preview for this view
struct AnimationOverlay_Previews: PreviewProvider {
    static var previews: some View {
        AnimationOverlay()
    }
}
