//
//  Test.swift
//  a2-s3407778
//
//  Created by Ethan Herpich on 19/9/2023.
//

import SwiftUI

import SwiftUI

struct Test: View {
    @State private var rectangle1Position: CGPoint = .zero
    @State private var isDragging: Bool = false
    @State private var success: Bool = false
    @State private var rectangle2Position: CGPoint = .zero
    @State private var rectangle3Position: CGPoint = .zero
    
    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]

    var body: some View {
        ZStack{
            
            GeometryReader { geo in
                LazyVGrid(columns: columns, spacing: 0) {
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.blue)
                        .position(rectangle1Position)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if !isDragging {
                                        isDragging = true
                                    }
                                    rectangle1Position = CGPoint(x: value.location.x, y: value.location.y)
                                    checkForSuccess()
                                    print("X: \(rectangle1Position.x), Y: \(rectangle1Position.y)")
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                        .onAppear {
                            // Set initial position for the draggable rectangle
                            rectangle1Position = CGPoint(x: 50, y: 50)
                            //rectangle1Position = CGPoint(x: geo.size.width / 2, y: 50)
                        }
                    
                    
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.green)
                        .position(rectangle2Position)
                        .onAppear {
                            // Calculate the position of rectangle2 dynamically
                            rectangle2Position = CGPoint(x: 50, y: 50)
                            
                            //Rect 2, X: 196.5, Y: 279.5
                        }
                    
                    
                    Rectangle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.yellow)
                        .position(rectangle3Position)
                        .onAppear {
                            // Calculate the position of rectangle3 dynamically
                            rectangle3Position = CGPoint(x: 50, y: 50)
                            
                            //
                            //Rect 3, X: 196.5, Y: 479.5
                        }
                }
                .background(Color.gray.opacity(0.2))
                .frame(width: 400, height: 200, alignment: .topLeading)
                
                
            }
            .background(Color.gray.opacity(0.2))
            .frame(width: .zero, height: .zero, alignment: .topLeading)
            //.offset(y: -50)
            
        }
    }

    private func checkForSuccess() {
        let rect2Frame = CGRect(x: rectangle2Position.x, y: rectangle2Position.y, width: 100, height: 100)
        let rect3Frame = CGRect(x: rectangle3Position.x, y: rectangle3Position.y, width: 100, height: 100)

        if rect2Frame.intersects(CGRect(origin: rectangle1Position, size: CGSize(width: 100, height: 100))) ||
           rect3Frame.intersects(CGRect(origin: rectangle1Position, size: CGSize(width: 100, height: 100))) {
            success = true
            
            print("Rect 2, X: \(rectangle2Position.x), Y: \(rectangle2Position.y)")
            print("Rect 3, X: \(rectangle3Position.x), Y: \(rectangle3Position.y)")
            print("Success")
        } else {
            success = false
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}




