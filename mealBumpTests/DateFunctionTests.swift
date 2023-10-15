//
//  DateFunctionTests.swift
//  mealBumpTests
//
//  Created by Ethan Herpich on 15/10/2023.
//

import XCTest
@testable import a2_s3407778

final class DateFunctionTests: XCTestCase {
    
    func testSuccessfulConversion_DateToString() throws {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let dateObject = dateFormatter.date(from: "2023-10-1 00:00:00 +0000")
        
        // When
        let result = dateToString(date: dateObject!)
        
        // Then
        XCTAssertEqual(result, "2023-10-01")
        
    }

    func testSuccessfulConversion_StringToDate() throws {
        // Given
        let stringInput = "2023-10-15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let dateObject = dateFormatter.date(from: "2023-10-15 00:00:00 +0000")
        
        // When
        let result = try stringToDate(dateString: stringInput)
    
        // Then
        XCTAssertEqual(result, dateObject)
        
    }
    
    
    func testUnsuccessfulConversion_StringToDate() throws {
        // Given
        let stringInput = "2023-50-15"
        
        // When
        //let result = try stringToDate(dateString: stringInput)
        XCTAssertThrowsError(try stringToDate(dateString: stringInput)) { (error) in
            
            // Then
            XCTAssertEqual(error as? DateFormatError, DateFormatError.invalidDateFormat)
        }
    
        
        
        
    }

    func testSuccessfulConversion_WeekdayFromDate() throws {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let inputDate = dateFormatter.date(from: "2023-10-15 00:00:00 +0000")
        
        // When
        let result = weekdayFromDate(date: inputDate!)
        
        // Then
        XCTAssertEqual(result, "Sunday")
    }
    
    func testSuccessfulConversion_DayNumberFromDate() throws {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let inputDate = dateFormatter.date(from: "2023-10-15 00:00:00 +0000")
        
        // When
        let result = dayNumberFromDate(date: inputDate!)
        
        // Then
        XCTAssertEqual(result, "15")
        
    }
    
    func testSuccessfulConversion_GenerateDateArray() throws {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        let inputDate = dateFormatter.date(from: "2023-10-15 00:00:00 +0000")
        
        let mondayDate = dateFormatter.date(from: "2023-10-09 00:00:00 +0000")
        let tuesdayDate = dateFormatter.date(from: "2023-10-10 00:00:00 +0000")
        let wednesdayDate = dateFormatter.date(from: "2023-10-11 00:00:00 +0000")
        let thursdayDate = dateFormatter.date(from: "2023-10-12 00:00:00 +0000")
        let fridayDate = dateFormatter.date(from: "2023-10-13 00:00:00 +0000")
        let saturdayDate = dateFormatter.date(from: "2023-10-14 00:00:00 +0000")
        let sundayDate = dateFormatter.date(from: "2023-10-15 00:00:00 +0000")
        
        let weekArray = [mondayDate, tuesdayDate, wednesdayDate, thursdayDate, fridayDate, saturdayDate, sundayDate]
        
        // When
        let result = generateDateArray(selectedDate: inputDate!)
        
        // Then
        XCTAssertEqual(result, weekArray)
        
    }
    
    

}
