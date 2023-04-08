//
//  OnBoardingManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation


class OnBoardingManager:ObservableObject{
    @Published var onBoardingData:[OnBoardingModel] = []
    @Published var offSet:CGFloat = 0
    init(){
        getOnboardingData()
    }
    
    private func getOnboardingData(){
        self.onBoardingData = [
            .init(image: "house", title: "Welcome Back", description: "We are very excited to see you Back!", Color: .blue),
            .init(image: "person", title: "Perfect!", description: "We are very excited to see you Back!", Color: .red),
            .init(image: "gear", title: "Most Advanced", description: "We are very excited to see you Back!", Color: .green),
        ]
    }
}
