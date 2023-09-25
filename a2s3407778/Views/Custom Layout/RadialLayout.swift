//
//  RadialView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 25/8/2023.
//

import Foundation
import SwiftUI

struct RadialLayout: Layout { // This is the actual layout.... everything else in this file is using this to create an example of how it can be used...
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        // accept the full proposed space, replacing any nil values with a sensible default
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        // Calculate the radius of our bounds
        let radius = min(bounds.size.width, bounds.size.height) / 2 - 60
        
        // Calculate the angle between each subview on our half circle
        let angleIncrement = CGFloat.pi / CGFloat(subviews.count + 1)
        
        for (index, subview) in subviews.enumerated() {
            
            // Calculate the angle for the current index
            let angle = angleIncrement * CGFloat(index + 1)
            
            // Calculate the x-coordinate based on the angle and radius
            let x = radius * cos(angle)
            
            // Calculate the y-coordinate, using a negative value to position the subviews at the top of the half circle
            let y = -radius * sin(angle)
            
            // Calculate the center point of the subview based on the coordinates
            let center = CGPoint(x: x + bounds.midX, y: y + bounds.maxY)
            
            // Place the subview at the calculated center point, anchoring at the center
            subview.place(at: center, anchor: .center, proposal: .unspecified)
            
            
        }
    }
    
}
