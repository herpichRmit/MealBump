//
//  InitialLayout.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 25/9/2023.
//


import Foundation
import SwiftUI

/// Provides an inital position for the CustomMenu buttons
struct InitialLayout: Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        
        // accept the full proposed space, replacing any nil values with a sensible default
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        
        // Map the flexibility property of each subview into an array.
        let anchors = subviews.map { subview in
            subview[StartPosition.self]
        }
        
        
        for (index, subview) in subviews.enumerated() {
            
            let anchor = anchors[index]
            
            // Calculate the center point of the subview
            let center = CGPoint(x: anchor.x + bounds.minX, y: anchor.y + bounds.minY - 50)
            
            // Place the subview at the calculated center point, anchoring at the center
            subview.place(at: center, anchor: .center, proposal: .unspecified)
            
        }
        
    }
    
}

struct StartPosition: LayoutValueKey {
    static var defaultValue: CGPoint = CGPoint(x: 0.0, y: 0.0)
}

extension View {
    func anchor(_ value: CGPoint) -> some View {
        layoutValue(key: StartPosition.self, value: value)

    }
}
