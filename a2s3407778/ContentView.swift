//
//  ContentView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 7/8/2023.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
                 
        TabView{
            ShoppingView()
                .tabItem(){
                    Image(systemName: "cart")
                    Text("Shopping List")
                }
            DayView()
                .tabItem(){
                    Image(systemName: "sun.min")
                    Text("Daily")
                }
            WeekPlannerView()
                .tabItem(){
                    Image(systemName: "clock")
                    Text("Weekly")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
