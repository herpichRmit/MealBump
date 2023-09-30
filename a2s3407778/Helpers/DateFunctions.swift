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
