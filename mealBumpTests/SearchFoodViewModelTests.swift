//
//  SearchFoodViewModelTests.swift
//  mealBumpTests
//
//  Created by Ethan Herpich on 15/10/2023.
//

import XCTest
@testable import a2_s3407778

final class SearchFoodViewModelTests: XCTestCase {
    

    func testSuccesfulFetchAutocomplete() throws {
        // Given
        let autocompleteViemModel = AutocompleteViewModel()
        let searchText = "appl"
        
        guard let filePath = Bundle.main.path(forResource: "SpoonacularAPI-Secret", ofType: "plist") else {
            fatalError("Couldn't find file 'SpoonacularAPI-Secret.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'SpoonacularAPI-Secret.plist'.")
        }
        if (value.starts(with: "_")) {
            fatalError("Please replace API_KEY with key from spoonacular.com")
        }

        
        // When
        // Note: Testing for asynchronous calls using XCTestExpectation
        autocompleteViemModel.isSuccessful = true
        let expectation = XCTestExpectation(description: "Test network call")
        autocompleteViemModel.fetchAutocomplete(keyword: searchText, apiKey: value) { _ in
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
        
        // Then
        // Note: to reduce undue complexity, instead of doing a direct comparison through XCTAssertEqual, the size will be measured and the first item compared.
        XCTAssertEqual(autocompleteViemModel.autocompleteData.count, 10)
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].name, "apple")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].image, "apple.jpg")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].id, 9003)
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].aisle, "Produce")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].possibleUnits, [
            "small", "large", "piece", "slice", "g", "extra small", "medium", "oz", "cup slice", "NLEA serving", "cup", "serving"
        ])

    }
    
    func testSuccesfulFetchAutocomplete_twoKeywords() throws {
        // Given
        let autocompleteViemModel = AutocompleteViewModel()
        let searchText = "apple "
        
        guard let filePath = Bundle.main.path(forResource: "SpoonacularAPI-Secret", ofType: "plist") else {
            fatalError("Couldn't find file 'SpoonacularAPI-Secret.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'SpoonacularAPI-Secret.plist'.")
        }
        if (value.starts(with: "_")) {
            fatalError("Please replace API_KEY with key from spoonacular.com")
        }
        
        // When
        // Note: Testing for asynchronous calls using XCTestExpectation
        autocompleteViemModel.isSuccessful = true
        let expectation = XCTestExpectation(description: #function)
        autocompleteViemModel.fetchAutocomplete(keyword: searchText, apiKey: value) { _ in
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
        
        // Then
        // Note: to reduce undue complexity, instead of doing a direct comparison through XCTAssertEqual, the size will be measured and the first item compared.
        XCTAssertEqual(autocompleteViemModel.autocompleteData.count, 10)
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].name, "apple juice")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].image, "apple-juice.jpg")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].id, 9016)
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].aisle, "Beverages")
        XCTAssertEqual(autocompleteViemModel.autocompleteData[0].possibleUnits, [
            "g", "drink box", "oz", "teaspoon", "bottle NFS", "fluid ounce", "cup", "serving", "tablespoon"
        ])

    }
    
    func testSuccesfulFetchAutocomplete_noKeyword() throws {
        // Given
        let autocompleteViemModel = AutocompleteViewModel()
        let searchText = ""
        
        guard let filePath = Bundle.main.path(forResource: "SpoonacularAPI-Secret", ofType: "plist") else {
            fatalError("Couldn't find file 'SpoonacularAPI-Secret.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'SpoonacularAPI-Secret.plist'.")
        }
        if (value.starts(with: "_")) {
            fatalError("Please replace API_KEY with key from spoonacular.com")
        }
        
        // When
        // Note: Testing for asynchronous calls using XCTestExpectation
        autocompleteViemModel.isSuccessful = true
        let expectation = XCTestExpectation(description: #function)
        autocompleteViemModel.fetchAutocomplete(keyword: searchText, apiKey: value) { _ in
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
        // Then
        // Note: to reduce undue complexity, instead of doing a direct comparison through XCTAssertEqual, the size will be measured.
        XCTAssertEqual(autocompleteViemModel.autocompleteData.count, 0)

    }
    
    func testUnsuccesfulFetchAutocomplete_BadAPIKey() throws {
        // Given
        let autocompleteViemModel = AutocompleteViewModel()
        let searchText = "appl"
        let value = "bad-api-key"
        
        // When
        // Note: Testing for asynchronous calls using XCTestExpectation
        autocompleteViemModel.isSuccessful = true
        let expectation = XCTestExpectation(description: #function)
        autocompleteViemModel.fetchAutocomplete(keyword: searchText, apiKey: value) { _ in
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
        // Then
        // Note: to reduce undue complexity, instead of doing a direct comparison through XCTAssertEqual, the size will be measured.
        XCTAssertEqual(autocompleteViemModel.autocompleteData.count, 0)

    }

    

}
