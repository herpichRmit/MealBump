//
//  DateStructs.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 25/9/2023.
//

import Foundation

// Function to convert a date to a string
func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    let timeString = dateFormatter.string(from: date)
    return timeString
}

// Function to convert a string to a date
func stringToDate(dateString: String) -> Date {
  
    let dateFormatter = DateFormatter() // Create dateformatter object
    dateFormatter.dateFormat = "yyyy-MM-dd" // Set the date formatter format
    
    if let date = dateFormatter.date(from: dateString) {
        return date
    } else {
        fatalError("Invalid date format") // If the conversion fails, crash the program
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
