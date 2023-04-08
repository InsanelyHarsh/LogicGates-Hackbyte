//
//  OnBoardingLayoutView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct OnBoardingLayoutView: View {
    let onBoardingData:OnBoardingModel
        var body: some View {
            VStack(alignment:.center,spacing: 90){
                HStack{
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .frame(width: 40, height: 30)
                    
                    Spacer()
                }
//                .frame(maxWidth: .infinity)
                .padding(.leading)
                
                
                Image(systemName: onBoardingData.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                VStack(alignment:.center){
                
                    Text(onBoardingData.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(onBoardingData.description)
                        .font(.headline)
                }
                .padding(.bottom,35)
                
                Spacer()
            }
//            .frame(maxWidth: .infinity)
//            .padding(.horizontal)
        }
}

struct OnBoardingLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingLayoutView(onBoardingData: .init(image: "house", title: "Welcome Back", description: "We are very excited to see you Back!", Color: .blue))
    }
}
