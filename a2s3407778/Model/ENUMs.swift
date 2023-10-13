//
//  ShopItemCategoryENUM.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 9/10/2023.
//

import Foundation
import SwiftUI

<<<<<<< Updated upstream
enum ShopItemCategory: String, CaseIterable {
    case Dairy, Produce, Meat, Pasta, Fish, Lollies, Drinks, Other, Stationary, Cleaning, Household, Personal, Spices, Bakery, None
=======
// CaseIterable allows access to the randomeElement() function for creating random elements for testing
// CaseIterable and Identifiable allow use with ForEach loops


enum ShopItemCategory: String, CaseIterable, Identifiable {
    var id: Self { self }

    case Dairy, Produce, Meat, Pasta, Fish, Lollies, Drinks, Other, Stationary, Cleaning, Household, Personal, Spices, Bakery
>>>>>>> Stashed changes
}

enum EventType: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case ShoppingTrip
    case Meal
    case SkippedMeal
    case Other
}

enum EventMealKind: String, CaseIterable, Identifiable {
    var id: Self { self }
    case Breakfast, Lunch, Dinner, Snack
}
