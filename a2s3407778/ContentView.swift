//
//  ContentView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 7/8/2023.
//

import SwiftUI

/// Base View which contains the TabView for switching between the 3 Main views
struct ContentView: View {
    
    @EnvironmentObject var settings: DateObservableObject
    
    var body: some View {
        ZStack{
            TabView(selection: $settings.openTab){
                ShoppingView()
                    .tabItem(){
                        Image(systemName: "cart")
                        Text("Shopping List")
                    }
                    .tag("shoppinglist")
                    .onAppear(){
                        settings.openTab = "shoppinglist"
                    }
                DayView()
                    .tabItem(){
                        Image(systemName: "sun.min")
                        Text("Daily")
                    }
                    .tag("daily")
                    .onAppear(){
                        settings.openTab = "daily"
                    }
                WeekPlannerView()
                    .tabItem(){
                        Image(systemName: "clock")
                        Text("Weekly")
                    }
                    .tag("weekly")
                    .onAppear(){
                        settings.openTab = "weekly"
                    }
            }
            .onAppear {
                // correct the transparency bug for Tab bars
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                // correct the transparency bug for Navigation bars
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
            // When the plus button in WeekDayEntry is pressed, the menu animation and menu is shown as an overlay to the screen.
            AnimationOverlay()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
