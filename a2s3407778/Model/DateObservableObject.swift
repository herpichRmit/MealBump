//
//  DateObservableObject.swift
//  a2-s3407778
//
//  Created by Charles Blyton on 2/10/2023.
//

import Foundation

// EnvironmentObjects must be classes with @Published variables

// We could rename this class to something else if we wanted to share other things in the environment

final class DateObservableObject: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var showActionMenu = false
    @Published var showCreateMealSheet = false
    @Published var showCreateShopSheet = false
    @Published var showCreateOtherSheet = false
    @Published var showSearchMealSheet = false
    @Published var animateActionMenu = false
    @Published var activateSheetPosition: CGPoint = .zero
}
