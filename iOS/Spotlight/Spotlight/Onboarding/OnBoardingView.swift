//
//  OnBoardingView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct OnBoardingView: View {
    @StateObject var onBoardingManager:OnBoardingManager = OnBoardingManager()
    var screenSize:CGSize
    let action:()->Void
    var body: some View {
        
        OffsetPageView(offSet: $onBoardingManager.offSet) {
            ZStack{
                Image("background")
                    .frame(width: screenSize.width*3)
                    .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    ForEach(onBoardingManager.onBoardingData){ data in
                        OnBoardingLayoutView(onBoardingData: data)
                            .frame(width: screenSize.width)
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            }
        }
        .overlay(alignment: .bottom){
            CustomButton(buttonTitle: "Continue..", action: action)
                .padding(.bottom,50)
        }

        .ignoresSafeArea()
    }
    
    
    func getIndex()->Int{
        let off = round(onBoardingManager.offSet/screenSize.width)
        return Int(off)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ g in
            OnBoardingView(screenSize: g.size){
                
            }
        }
    }
}
