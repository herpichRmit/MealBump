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
    
    // list of all events in the dat
    @State var dayInfo : [Event]
    
    // allows for reordering of cards
    @State var isMoveable : Bool = true
    
    // control what modal is being shown
    @Binding var isMenuShown : Bool
    @Binding var showActionSheet : Bool
    @Binding var showCreateMealSheet : Bool
    @Binding var showCreateShopSheet : Bool
    @Binding var showCreateOtherSheet : Bool
    @Binding var showSearchMealSheet : Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 8) {
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
                weekday = dateFormatter.string(from: dayInfo[0].date)
                
                // determine day number from date
                dateFormatter.setLocalizedDateFormatFromTemplate("d")
                dayNumber = dateFormatter.string(from: dayInfo[0].date)
                
            }
            
            // row of cards
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10) {
                    
                    // this swiftUI package allows for cards to be dragged and dropped, demonstrating future functionality that will be imbedded in the system
                    ReorderableForEach($dayInfo, allowReordering: $isMoveable) { item, isDragged in
                        if item.title != "n/a" {
                            WeekEventCard(event: item)
                        }
                    }

                    // sheet view contains all the different modal sheets and forms
                    SheetView(
                        dayInfo: $dayInfo,
                        isMenuShown: $isMenuShown,
                        showActionSheet: $showActionSheet,
                        showCreateMealSheet: $showCreateMealSheet,
                        showCreateShopSheet: $showCreateShopSheet,
                        showCreateOtherSheet: $showCreateOtherSheet,
                        showSearchMealSheet: $showSearchMealSheet
                    )
                    
                }
                .frame(height: 160, alignment: .top)
                .padding([.top, .leading], 2)
                .padding([.trailing], 10)
            }
            
            
        }
        .frame(width: 343, height: 180, alignment: .topLeading)
    }

    
}
