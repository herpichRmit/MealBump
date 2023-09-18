//
//  ViewA.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI

struct ViewA: View {
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                Text("1")
            }
            .navigationTitle("Planner  August")
        }
        
    }
}

struct ViewA_Previews: PreviewProvider {
    static var previews: some View {
        ViewA()
    }
}
