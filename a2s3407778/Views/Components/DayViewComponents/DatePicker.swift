//
//  DatePicker.swift
//  a1s3407778
//
//  Created by Charles Blyton on 18/8/2023.
//

import SwiftUI


struct DatePicker: View {
    //    State variable for trying to make scrolling and pagination work
    //    @State var weeks: [[Date]] = []
    
    @Binding var selectedDate: Date
    
    var body: some View {
        // MARK: Attempted to create a paginated horizontal scrolling view for each week of dates. After research this appears to be very easy in ios17 with a .scrollTargetLayout() and .scrollTargetBehavior(). Can implement this when permitted to upgrade to xcode15
        
        // Generating this week's dates
        let currentWeek = generateDateArray(selectedDate: selectedDate)
        
        //        //         Generating Next week's dates
        //        let nextWeek = generateDateArray(
        //            selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!)
        //
        //        //         Generating last week's dates
        //        let previousWeek = generateDateArray(
        //            selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!)
        
        HStack{
            ForEach(currentWeek, id: \.self) { week in
                DateTile(selectedDate: $selectedDate, date: week) //Make a dateTile with that date
            }
        }
    }
}

struct DateTile: View  {
    
    @Binding var selectedDate: Date
    
    var date: Date
    
    var body: some View {
        
        // Choosing if selected dateTile or unselected dateTile is shown
        if dateToString(date: date) == dateToString(date: selectedDate) {
            
            // Currently Selected Tile
            Button {
                selectedDate = date
                
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
            
        } else { // Non Selected Tile
            Button {
                selectedDate = date
                
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

// Calculating the 7 dates to be shown based on the selected date
func generateDateArray(selectedDate: Date) -> [Date] {
    
    // Setting a calendar that starts on monday rather than gregorian
    let myCalendar = Calendar(identifier: .iso8601)
    
    // Getting the year from the current date
    let yearForWeekOfYear = myCalendar.component(.yearForWeekOfYear, from: selectedDate)
    
    //Getting the week number from current date
    let weekNumber  = myCalendar.component(.weekOfYear, from: selectedDate)
    
    //Calculating the date of the monday of the week that the selected date is in
    let mondayOfWeek = DateComponents(calendar: myCalendar, weekOfYear: weekNumber, yearForWeekOfYear: yearForWeekOfYear).date!
    
    //Creating a new Date Array
    var weekArray = [Date]()
    
    //Add Calculated Monday to array
    weekArray.append(mondayOfWeek)
    
    for _ in 1 ... 6 {
        // iterating by one day(value) from the previous date in the array
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: weekArray.last ?? mondayOfWeek)
        // Pretty sure unconditional unwrapping is ok here because used nil coalescing operator in previous step
        weekArray.append(modifiedDate!)
    }
    
    return weekArray
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
