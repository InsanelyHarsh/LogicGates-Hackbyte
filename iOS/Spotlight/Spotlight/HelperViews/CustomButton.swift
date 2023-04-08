//
//  CustomButton.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct CustomButton: View {
    var isPrimary:Bool = true
    let buttonTitle:String
    let action:()->Void
    let buttonColor:Color = .black
    
    var body: some View {
        Button(buttonTitle, action: action)
            .foregroundColor(isPrimary ? .white : .black)
            .padding()
            .padding(.horizontal, buttonTitle.count < 6 ? 10 : 0)
            .background{
                if(isPrimary){
                    buttonColor.cornerRadius(8)
                }else{
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                }
            }
            .foregroundColor(buttonColor)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            CustomButton(buttonTitle: "Press Me") {
                
            }
            
            CustomButton(isPrimary: false,buttonTitle: "Press Me") {
                
            }
        }
    }
}
