//
//  DateFunctionsTests.swift
//  a2-s3407778Tests
//
//  Created by Charles Blyton on 14/10/2023.
//

import XCTest
@testable import a2_s3407778 //XCode just doesn't like the dash, prefers underscore


final class DateFunctionsTests: XCTestCase {
    
    func testSuccessfulConvertStringToDate(){
        // (Given)
        let testDateString = "1991-08-03"
        
        // (Arrange)
        let result = stringToDate(dateString: testDateString)
        
        
        
        // (Act)
        XCTAssertEqual(result, <#T##expression2: Equatable##Equatable#>)
    }
}
