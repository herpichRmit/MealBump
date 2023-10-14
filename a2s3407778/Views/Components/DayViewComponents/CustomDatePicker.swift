//
//  CustomDatePicker.swift
//  a1s3407778
//
//  Created by Charles Blyton on 18/8/2023.
//

import SwiftUI

/// View which describes the custom date picker used in the DayView
struct CustomDatePicker: View {
    
    @EnvironmentObject var settings: DateObservableObject

    var body: some View {
        
        // Generating this week's dates
        let currentWeek = generateDateArray(selectedDate: settings.selectedDate)
        
        
    // MARK: Attempted to create a paginated horizontal scrolling view for each week of dates. After research this appears to be very easy in ios17 with a .scrollTargetLayout() and .scrollTargetBehavior(). Can implement this when permitted to upgrade to xcode15
        //        //         Generating Next week's dates
        //        let nextWeek = generateDateArray(
        //            selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!)
        //
        //        //         Generating last week's dates
        //        let previousWeek = generateDateArray(
        //            selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!)
        
        HStack{
            ForEach(currentWeek, id: \.self) { week in
                DateTile(date: week) //Make a dateTile with that date
            }
        }
    }
}

/// Struct which is the actual 7 dates listed in the picker. Displays blue circle with white text if day is selected. White background with black text if the day is visable and selectable,
/// but is not currently selected. 
struct DateTile: View  {
        
    @EnvironmentObject var settings: DateObservableObject

    var date: Date
    
    var body: some View {
        
        // Choosing if selected dateTile or unselected dateTile is shown
        if dateToString(date: date) == dateToString(date: settings.selectedDate) {
            
            // Currently Selected Tile (Blue Circle Background)
            Button {
                settings.selectedDate = date
                
            } label: {
                ZStack{
                    Circle()
                        .fill(.indigo)
                        .frame(width: 45, height:45)
                    VStack{
                        // Formatting the date to get the shortened day letters
                        Text(date.formatted(Date.FormatStyle().weekday(.short)))
                            .font(.caption)
                            .foregroundColor(Color.white)
                        //Formatting the date to get the day
                        Text(date.formatted(Date.FormatStyle().day(.defaultDigits)))
                            .font(.footnote)
                            .foregroundColor(Color.white)
                    }
                }
            }
            
        } else { // Non Selected Tile (White background)
            Button {
                settings.selectedDate = date
                
            } label: {
                ZStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 45, height:45)
                    VStack{
                        // Formatting the date to get the shortened day letters
                        Text(date.formatted(Date.FormatStyle().weekday(.short)))
                            .font(.caption)
                            .foregroundColor(Color.black)
                        //Formatting the date to get the day
                        Text(date.formatted(Date.FormatStyle().day(.defaultDigits)))
                            .font(.footnote)
                            .foregroundColor(Color.black)
                        
                    }
                }
            }
        }
    }
}

/// Struct to enable Canvas/Live Preview for this view
struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
