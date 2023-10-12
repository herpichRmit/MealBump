//
//  RadialView.swift
//  a1s3407778
//
//  Created by Charles Blyton on 25/8/2023.
//

import Foundation
import SwiftUI

enum CircleDirection {
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}


struct RadialLayout: Layout { // This is the actual layout.... everything else in this file is using this to create an example of how it can be used...
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        // accept the full proposed space, replacing any nil values with a sensible default
        return proposal.replacingUnspecifiedDimensions()
    }
    
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
            
        // Map the flexibility property of each subview into an array.
        let anchors = subviews.map { subview in
            subview[StartPosition.self]
        }
        
        // Calculate the radius of the bounds
        let radius = min(bounds.size.width, bounds.size.height) / 2 - 60
        
        // Calculate the direction based on button proximity to edges
        var direction: CircleDirection = .top  // Default direction is top
        
        // Adjust the angle based on direction
        let angleIncrement = CGFloat.pi / CGFloat(subviews.count + 1)
        
        for (index, subview) in subviews.enumerated() {
            
            // Set the anchor for the current subview
            let anchor = anchors[index]
            
            // Calculate the distance of the anchor point from the edges
            let distanceToLeftEdge = anchor.x
            let distanceToRightEdge = bounds.size.width - anchor.x
            let distanceToTopEdge = anchor.y
            let distanceToBottomEdge = bounds.size.height - anchor.y
            
            // Calculate the minimum distance from the edges
            let minDistanceLeftRightEdge = 100.0
            let minDistanceBottomEdge = 150.0
            let minDistanceTopEdge = 250.0
            
            // Calculate the direction based on proximity to edges
            if distanceToRightEdge <= minDistanceLeftRightEdge && distanceToBottomEdge <= minDistanceBottomEdge {
                print("1")
                direction = .topLeft
            } else if distanceToLeftEdge <= minDistanceLeftRightEdge && distanceToBottomEdge <= minDistanceBottomEdge {
                print("2")
                direction = .topRight
            } else if distanceToRightEdge <= minDistanceLeftRightEdge && distanceToTopEdge <= minDistanceTopEdge {
                print("3")
                direction = .bottomRight
            } else if distanceToLeftEdge <= minDistanceLeftRightEdge && distanceToTopEdge <= minDistanceTopEdge {
                print("4")
                direction = .bottomLeft
            } else if distanceToRightEdge <= minDistanceLeftRightEdge {
                print("5")
                direction = .left
            } else if distanceToLeftEdge <= minDistanceLeftRightEdge {
                print("6")
                direction = .right
            } else {
                direction = .top
            }
            
            
            var adjustedAngle = CGFloat.pi - angleIncrement * CGFloat(index + 1)
            
            if direction == .left {
                adjustedAngle = CGFloat.pi/2 + angleIncrement * CGFloat(index + 1)
            } else if direction == .right {
                adjustedAngle = CGFloat.pi/2 - angleIncrement * CGFloat(index + 1)
            } else if direction == .topLeft {
                adjustedAngle = CGFloat.pi/3 + angleIncrement * CGFloat(index + 1)
            } else if direction == .topRight {
                adjustedAngle = (CGFloat.pi/3)*2 - angleIncrement * CGFloat(index + 1)
            } else if direction == .bottomLeft {
                adjustedAngle = CGFloat.pi/3 - angleIncrement * CGFloat(index + 1)
            } else if direction == .bottomRight {
                adjustedAngle = (CGFloat.pi/3)*2 + angleIncrement * CGFloat(index + 1)
            }
            
            // Calculate the x-coordinate based on the adjusted angle and radius
            let x = radius * cos(adjustedAngle)
            
            // Calculate the y-coordinate based on the adjusted angle and radius
            let y = -radius * sin(adjustedAngle)
            
            // Calculate the center point of the subview
            let center = CGPoint(x: anchor.x + x + bounds.minX, y: anchor.y + y + bounds.minY - 50)
            
            // Place the subview at the calculated center point, anchoring at the center
            subview.place(at: center, anchor: .center, proposal: .unspecified)
        }
    }

}





