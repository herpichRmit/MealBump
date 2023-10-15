//
//  DateStructs.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 25/9/2023.
//

import Foundation

/// Function to convert a date to a string
func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    let timeString = dateFormatter.string(from: date)
    return timeString
}

/// Function to convert a string to a date
func stringToDate(dateString: String) throws -> Date {
  
    let dateFormatter = DateFormatter() // Create dateformatter object
    dateFormatter.dateFormat = "yyyy-MM-dd" // Set the date formatter format
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let date = dateFormatter.date(from: dateString) {
        return date
    } else {
        throw DateFormatError.invalidDateFormat
    }
}

/// Function to calculate which day of the week a particular date is and return the name of that day as a string
func weekdayFromDate (date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
    return dateFormatter.string(from: date)
}

/// Function to that returns the day of the month as a string (1-31)
func dayNumberFromDate (date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("d")
    return dateFormatter.string(from: date)
    
}

/// Function to return the 7 dates of the week (monday-sunday) that contains the selected date
func generateDateArray(selectedDate: Date) -> [Date] {
    
    // Setting a calendar that starts on monday rather than gregorian
    var myCalendar = Calendar(identifier: .iso8601)

    myCalendar.timeZone = TimeZone(secondsFromGMT: 0)!
    
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

/// Enum to handle custom error case
enum DateFormatError: Error {
    case invalidDateFormat
}
