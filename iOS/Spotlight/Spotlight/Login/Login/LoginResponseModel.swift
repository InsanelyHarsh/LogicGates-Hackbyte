//
//  LoginResponseModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel:Decodable {
    var success: Bool?
    var message, authToken: String?
    var user: LoginUser?
}

// MARK: - User
struct LoginUser:Decodable {
    var id, name, email, username: String?
}
