//
//  ShopItemCategoryENUM.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 9/10/2023.
//

import Foundation
import SwiftUI

enum ShopItemCategory: String, CaseIterable {
    case Dairy, Produce, Meat, Pasta, Fish, Lollies, Drinks, Other, Stationary, Cleaning, Household, Personal, Spices, Bakery
}

enum EventType: String, CaseIterable {
    // CaseIterable allows access to the randomeElement() function for creating random elements for testing
    case ShoppingTrip
    case Meal
    case SkippedMeal
    case Other
}

enum EventMealKind: String, CaseIterable {
    case Breakfast, Lunch, Dinner, Snack
}
