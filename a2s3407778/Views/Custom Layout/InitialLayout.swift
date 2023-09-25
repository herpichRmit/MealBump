//
//  InitialLayout.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 25/9/2023.
//


import Foundation
import SwiftUI

struct InitialLayout: Layout {
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        // accept the full proposed space, replacing any nil values with a sensible default
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        
        for (index, subview) in subviews.enumerated() {
            
            
            let anchor = subviews[index][StartPosition.self]

            print(anchor)
            
            // Calculate the center point of the subview based on the coordinates
            let center = CGPoint(x: anchor.x + bounds.midX, y: anchor.y + bounds.maxY - 40 )
            
            // Place the subview at the calculated center point, anchoring at the center
            subview.place(at: center, anchor: .center, proposal: .unspecified)
            
        }
        
    }
    
}

struct StartPosition: LayoutValueKey {
    static var defaultValue: CGPoint = CGPoint(x: 100, y: 100)
}

extension View {
    func anchor(_ anchor: CGPoint) -> some View {
        self.layoutValue(key: StartPosition.self, value: anchor)

    }
}

extension LayoutSubview {
    var anchor: CGPoint {
        self[StartPosition.self]
    }
}
