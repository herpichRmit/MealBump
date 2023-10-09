//
//  ContentView.swift
//  customlayout
//
//  Created by Charles Blyton on 25/8/2023.
//

import SwiftUI


struct ExampleOfCustomLayout: View {
    
    @State var isMenuShown = true //Allows the button to work to show or hide the menu
    
    
    var body: some View {
        ZStack{ // Need a ZStack so the view appears above everything else
            
            VStack{
                //Ethan's Implementation of plus button
                PlusButton()
                    .onTapGesture(coordinateSpace: .global) { location in
                        isMenuShown = true
                    }

            }
            
            //If Statement that shows or hides the menu picker
            if isMenuShown {
                   
                //This is the custom layout that I made, you can add more or less buttons and it will adjust the spacing radially in a semi-circle at the bottom of the view
                
                RadialLayout {
                    Button {
                        isMenuShown.toggle() //Hides the buttons once pressed
                    } label: {
                        Bubble(colour: .blue, text: "Create  Meal", active: isMenuShown)
                    }
                    Button {
                        isMenuShown.toggle()
                    } label: {
                        Bubble(colour: .red, text: "Shopping Trip", active: isMenuShown)
                    }
                    Button {
                        isMenuShown.toggle()
                    } label: {
                        Bubble(colour: .green, text: "Add From Achive", active: isMenuShown)
                    }
                    Button {
                        isMenuShown.toggle()
                    } label: {
                        Bubble(colour: .purple, text: "Create Other", active: isMenuShown)
                    }
                }
            }
        }
    }
}


struct ExampleOfCustomLayout_Previews: PreviewProvider {
    static var previews: some View {
        ExampleOfCustomLayout()
    }
}