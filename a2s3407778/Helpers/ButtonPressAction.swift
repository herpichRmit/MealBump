//
//  ButtonPressAction.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 13/10/2023.
//

// Code is adapted from video
// TODO: reference

// https://www.youtube.com/watch?v=JdUs3GD2zzI


import Foundation
import SwiftUI

//  Written by SerialCoder.dev
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

//  Written by SerialCoder.dev
extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(ButtonPress(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
