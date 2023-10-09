//
//  ViewB.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI

struct ViewB: View {
    var body: some View {
        NavigationView {
            
            VStack(spacing: 30) {
                Text("2")
            }
            .navigationTitle("Planner  August")
        }
    }
}

struct ViewB_Previews: PreviewProvider {
    static var previews: some View {
        ViewB()
    }
}
