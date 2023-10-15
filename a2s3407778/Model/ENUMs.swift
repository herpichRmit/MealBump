//
//  ShopItemCategoryENUM.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 9/10/2023.
//

import Foundation
import SwiftUI

/// ENUM for storing the typs of categories which foods/shoppingItems can be assigned
enum ShopItemCategory: String, CaseIterable {
    case None, Dairy, Produce, Meat, Pasta, Fish, Lollies, Drinks, Other, Stationary, Cleaning, Household, Personal, Spices, Bakery, MilkEggsOtherDairy
}

/// ENUM for storing the different types which events may be assigned
enum EventType: String, CaseIterable {
    // CaseIterable allows access to the randomeElement() function for creating random elements for testing
    case ShoppingTrip
    case Meal
    case SkippedMeal
    case Other
}

/// ENUM containing the list of kinds of meals which Events of type 'Meal' are assigned
enum EventMealKind: String, CaseIterable {
    case Breakfast, Lunch, Dinner, Snack
}
