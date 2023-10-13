//
//  WeekPlannerView.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 18/8/2023.
//

import SwiftUI

struct WeekPlannerView: View {
    
    @Environment(\.managedObjectContext) private var viewContext //For accessing CoreData
<<<<<<< Updated upstream
    @EnvironmentObject var settings: DateObservableObject
    
    // needed for animating pickup card feature
    @State private var animatedTrigger: Bool = false
    let cardStartPoint: CGPoint = CGPoint(x: 300, y: 600)
    
    // for month date
    let dateFormatter = DateFormatter()
    
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
                    .onAppear{
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
                // When the plus button in WeekDayEntry is pressed, the animation and menu is shown as an overlay to the screen.
                AnimationOverlay()
            }
        }
    }
    
    // Used to animate the pick up and drop feature.
    func animateCardSelect(location: CGPoint) {
        animatedTrigger.toggle()
        settings.cardPosition = location
        withAnimation {
            settings.cardPosition = CGPoint(x:300, y:600)
        }
    }
    
    // Used to animate the pick up and drop feature.
    func animateCardPlace(location: CGPoint) {
        animatedTrigger.toggle()
        withAnimation {
            settings.cardPosition = location
=======
    
    @EnvironmentObject var settings: DateObservableObject
    
    
    var body: some View {
        // list of days
        VStack{
            HStack{
                Text("**Weekly Planner** August")
                    .font(.title2)
                    .padding()
                Spacer()
            }
            
            // Date Calculation must be done here so the CoreData fetchRequest has a date to construct the fetch request in WeekDayEntry()
            WeekDayEntry(
                startDate: startOfWeek(selectedDate: settings.selectedDate),
                endDate: endOfWeek(selectedDate: settings.selectedDate))

>>>>>>> Stashed changes
        }
    }
}

<<<<<<< Updated upstream
// Unwrapping tool used from stack overflow.
// TODO: from https://stackoverflow.com/questions/57021722/swiftui-optional-textfield

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
=======

struct WeekPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlannerView()
    }
>>>>>>> Stashed changes
}
