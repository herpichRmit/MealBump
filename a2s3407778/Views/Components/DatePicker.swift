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
        
        // Generating this week's dates
        let currentWeek = generateDateArray(selectedDate: selectedDate)
        
        // Generating Next week's dates
        //            let nextWeek = generateDateArray(
        //                selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!)
        
        // Generating last week's dates
        //            let previousWeek = generateDateArray(
        //                selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!)
        
        HStack{
            ForEach(currentWeek, id: \.self) { week in
                DateTile(selectedDate: $selectedDate, date: week) //Make a dateTile with that date
            }
        }
    }
}

// TODO: Attempt at making dates scrollable and paginated, not complete yet
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach(weeks, id: \.self) { week in
//                    HStack{
//                        ForEach((0...6), id: \.self) { // For all 7 of the dates in the array
//                            DateTile(selectedDate: $selectedDate, todaysEvents: $todaysEvents, date: week[$0]) //Make a dateTile with that date
//                        }
//                    }
//                    .frame(width: UIScreen.main.bounds.width)
//                }
//            }
//        }
//        .onAppear{
//            let nextWeek = generateDateArray(
//                selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!)
//
//            // Generating this week's dates
//            let currentWeek = generateDateArray(selectedDate: selectedDate)
//
//            let previousWeek = generateDateArray(
//                selectedDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!)
//
//            weeks = [previousWeek, currentWeek, nextWeek]
//        }
//    }
//}


struct DateTile: View  {
    
    // TODO: I think having the buttons in here might be causing the double tapping bug, but haven't been able to solve it yet
    
    @Binding var selectedDate: Date
    
    var date: Date
    
    var body: some View {
        
        if date.formatted(date: .numeric, time: .omitted) == selectedDate.formatted(date: .numeric, time: .omitted) {
            
            // Currently Selected Tile
            Button {
                selectedDate = date
                //todaysEvents = FetchTodaysEvents(dateRequested: selectedDate)
                
            } label: {
                ZStack{
                    Circle()
                        .fill(.indigo)
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
