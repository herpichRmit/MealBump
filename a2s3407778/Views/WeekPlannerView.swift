//
//  WeekPlannerView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

/// WeekPlannerView organises events by rows within a scroll view
/// It includes the functionality to navigate weeks via move buttons, and to reorder events between different days
struct WeekPlannerView: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
    @EnvironmentObject var settings: DateObservableObject
    
    // needed for animating pickup card feature
    @State private var animatedTrigger: Bool = false
    let cardStartPoint: CGPoint = CGPoint(x: 300, y: 600)
    
    // For Month title formatting
    let dateFormatter = DateFormatter()
    
    // For changing week function
    var calendar = Calendar.current
    @State private var slideLeft = false
    @State private var slideRight = false
    
    var body: some View {
        NavigationView {
            ZStack(){
                // Formatting for pickup and drop card feature.
                if settings.selectedPickupCard != nil {
                    WeekEventCard(
                        title: settings.selectedPickupCard?.name ?? "Unknown title",
                        mealKind: settings.selectedPickupCard?.mealKind ?? "Unknown mealKind",
                        type: settings.selectedPickupCard?.eventType ?? "Unknown eventType"
                    )
                    .animation(.easeInOut, value: animatedTrigger)
                    .zIndex(1)
                    .position(settings.cardPosition) // where the card is double tapped
                    .shadow(color: Color.white.opacity(0.07), radius: 15, x: 4, y: 10)
                    .onAppear {
                        animateCardSelect(location: settings.cardPosition) // move card to spot
                    }
                }
                
                VStack {
                    // Header.
                    HStack {
                        Text("**Weekly Planner** \(dateFormatter.string(from: settings.selectedDate) )")
                            .font(.title2)
                            .padding()
                            .onAppear(){
                                dateFormatter.dateFormat = "MMMM"
                            }
                        Spacer()
                        Button {
                            // change week, swipe animation
                            dateChangeBack()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Button {
                            // change week, swipe animation
                            dateChangeForward()
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        Spacer()
                    }
                    
                    // Content.
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // Create rows for each day.
                            ForEach(generateDateArray(selectedDate: settings.selectedDate), id: \.self) { day in
                                WeekDayEntry(filter: day)
                                    .onTapGesture { location in
                                        // dropping card
                                        if settings.selectedPickupCard != nil {
                                            animateCardPlace(location: location)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                
                                                // changing selectedEvent to have new date
                                                settings.selectedPickupCard?.date = day
                                                // clear placeholder value
                                                settings.selectedPickupCard = nil
                                            }
                                        }
                                    }
                            }
                            
                        }
                    }
                    .frame(minHeight: 300, alignment: .topLeading)
                    .padding( [.leading] )
                }
            }
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Color.green)
            //.animation(.easeOut(duration: 0.4))
            //.offset(x: slideLeft ? -UIScreen.main.bounds.width : 0)
            //.offset(x: slideRight ? UIScreen.main.bounds.width : 0)
        }
        
    }
    
    /// Changes the value of published  var `cardPosition` to a specific `CGPoint`
    func animateCardSelect(location: CGPoint) {
        animatedTrigger.toggle()
        settings.cardPosition = location
        withAnimation {
            settings.cardPosition = CGPoint(x:300, y:600)
        }
    }
    
    /// Changes the value of published  var `cardPosition` to a parameter `location`
    func animateCardPlace(location: CGPoint) {
        animatedTrigger.toggle()
        withAnimation {
            settings.cardPosition = location
        }
    }
    
    /// Changes the value of published  var `selectedDate` forward by 7 days
    func dateChangeForward() {
        // Add 7 days from the original date
        self.slideRight.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            settings.selectedDate = calendar.date(byAdding: .day, value: 7, to: settings.selectedDate) ?? Date()
        }
    }
    
    /// Changes the value of published  var `selectedDate` back by 7 days
    func dateChangeBack() {
        // Subtract 7 days from the original date
        self.slideLeft.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            settings.selectedDate = calendar.date(byAdding: .day, value: -7, to: settings.selectedDate) ?? Date()
        }
    }
}

// Unwrapping tool used from stack overflow.
// TODO: from https://stackoverflow.com/questions/57021722/swiftui-optional-textfield

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
