//
//  CustomView.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 9/10/2023.
//

import SwiftUI

struct CustomMenu: View {
    @EnvironmentObject var settings: DateObservableObject
    
    var body: some View {
        PlusButton()
            .onTapGesture(coordinateSpace: .global) { location in
                settings.animateActionMenu = true
                settings.activateSheetPosition = location

                // delay so animtion is applied
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    print("delay end")
                    settings.showActionMenu = true 
                }
            }
            .sheet(isPresented: $settings.showCreateMealSheet) {
                NewMealSheet()
            }
            .sheet(isPresented: $settings.showSearchMealSheet) {
                Form {
                    Button("Dismiss", action: { settings.showSearchMealSheet.toggle() })
                }
            }
            .sheet(isPresented: $settings.showCreateShopSheet) {
                Form {
                    Button("Dismiss", action: { settings.showCreateShopSheet.toggle() })
                }
            }
            .sheet(isPresented: $settings.showCreateOtherSheet) {
                Form {
                    Button("Dismiss", action: { settings.showCreateOtherSheet.toggle() })
                }
            }
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenu()
    }
}
