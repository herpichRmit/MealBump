//
//  DateObservableObject.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 2/10/2023.
//

import Foundation

// EnvironmentObjects must be classes with @Published variables

final class DateObservableObject: ObservableObject {
    @Published var selectedDate: Date = Date()
    
    @Published var showActionMenu = false
    
    @Published var showCreateMealSheet = false
    @Published var showCreateShopSheet = false
    @Published var showCreateOtherSheet = false
    @Published var showAddShoppingItemSheet = false
    
    @Published var showSearchMealSheet = false
    @Published var animateActionMenu = false
    @Published var activateSheetPosition: CGPoint = .zero
    @Published var selectedEvent: EventCore = EventCore()
    @Published var selectedPickupCard : EventCore?
    @Published var cardPosition: CGPoint = CGPoint(x: 0, y: 0)
}
