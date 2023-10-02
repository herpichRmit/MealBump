//
//  DayEntry.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 21/8/2023.
//

import SwiftUI
import SwiftUIReorderableForEach // package as seen in https://iosexample.com/drag-drop-to-reorder-items-in-swiftui/

// DayEntry shows the weekday, weeknumber and holds all of the meal cards

struct WeekDayEntry: View {
    @State var weekday : String?
    @State var dayNumber : String?
    @State var date : Date?
    
    // list of all events in the day
    @State var events : [Event]
    
    // allows for select card functionality
    @Binding var selectedEvent: [Event?]
    @Binding var cardPosition: CGPoint
    
    // allows for reordering of cards
    @State var isMoveable : Bool = true
    
    // control what modal is being shown
    @Binding var isMenuShown : Bool
    @Binding var showActionSheet : Bool
    @Binding var showCreateMealSheet : Bool
    @Binding var showCreateShopSheet : Bool
    @Binding var showCreateOtherSheet : Bool
    @Binding var showSearchMealSheet : Bool
    @Binding var buildActionSheet : Bool
    @Binding var activateSheetPosition : CGPoint
    

    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading) {
                Text(weekday ?? "")
                    .font(.system(size: 16))
                Text(dayNumber ?? "")
                    .font(.system(size: 19))
            }
            .onAppear(){
                // Caculate weekday and week number value by checking the date of the first event in the day
                
                // determine weekday from date
                let dateFormatter = DateFormatter()
                dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
                weekday = dateFormatter.string(from: events[0].date)
                
                // determine day number from date
                dateFormatter.setLocalizedDateFormatFromTemplate("d")
                dayNumber = dateFormatter.string(from: events[0].date)
                
            }
            
            // row of cards
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    
                    // this swiftUI package allows for cards to be dragged and dropped, demonstrating future functionality that will be imbedded in the system
                    ReorderableStack($events, allowReordering: $isMoveable) { item, isDragged in
                        if item.title != "n/a" {

                            WeekEventCard(event: item)
                                .onTapGesture(count: 2, coordinateSpace: .global) { location in
                                    cardPosition = location
                                    selectedEvent.append(item)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        events.removeAll { $0.id == selectedEvent[0]!.id }
                                    }
                                }
                            Spacer()

                        }
                    }

                    // sheet view contains all the different modal sheets and forms
                    SheetView(
                        events: $events,
                        isMenuShown: $isMenuShown,
                        showActionSheet: $showActionSheet,
                        showCreateMealSheet: $showCreateMealSheet,
                        showCreateShopSheet: $showCreateShopSheet,
                        showCreateOtherSheet: $showCreateOtherSheet,
                        showSearchMealSheet: $showSearchMealSheet,
                        buildActionSheet: $buildActionSheet,
                        activateSheetPosition: $activateSheetPosition
                    )
                    
                }
                .frame(height: 140, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
            }
            
            
        }
        .frame(height: 150, alignment: .topLeading)
    }

    
}

    
    

