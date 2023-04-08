//
//  CustomDivider.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        HStack(spacing:5){
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
            
            Text("Or")
                .font(.caption).foregroundColor(.secondary)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
        }
        .padding([.vertical,.horizontal],10)
    }
}
