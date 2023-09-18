//
//  ViewC.swift
//  a1s3407778
//
//  Created by Ethan Herpich on 14/8/2023.
//

import SwiftUI

struct ViewC: View {
    var body: some View {
        NavigationView {
            
            VStack(spacing: 30) {
                Text("3")
            }
            .navigationTitle("Planner  August")
        }
        
    }
}

struct ViewC_Previews: PreviewProvider {
    static var previews: some View {
        ViewC()
    }
}
