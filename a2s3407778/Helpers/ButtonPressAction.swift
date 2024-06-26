//
//  ButtonPressAction.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 13/10/2023.
//



// Reference
// Indently (2022) How to animate Button Presses in SwiftUI Tutorial 2022, Youtube, accessed 12 October 2023. https://www.youtube.com/watch?v=JdUs3GD2zzI


import Foundation
import SwiftUI

/// Structs in this file add animations to the custom menu buttons
struct ButtonPress: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
