//
//  OnBoardingModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI


struct OnBoardingModel:Identifiable{
    let id = UUID().uuidString
    let image:String
    let title:String
    let description:String
    let Color:Color
}
