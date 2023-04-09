//
//  LoginRequestModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation

// MARK: - LoginRequestModel
struct LoginRequestModel:Encodable {
    let email, password: String
}
