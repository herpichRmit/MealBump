//
//  ShopItemCategoryENUM.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 9/10/2023.
//

import Foundation

enum ShopItemCategory: String {
    case Dairy, Produce, Meat, Pasta, Fish, Lollies, Drinks, Other, Stationary, Cleaning, Household, Personal, Spices, Bakery
}

enum EventType: String, CaseIterable {
    // CaseIterable allows access to the randomeElement() function for creating random elements for testing
    case ShoppingTrip, Meal, SkippedMeal, Other
}

enum EventTimePeriod: String, CaseIterable {
    case Breakfast, Lunch, Dinner, Snack
}
