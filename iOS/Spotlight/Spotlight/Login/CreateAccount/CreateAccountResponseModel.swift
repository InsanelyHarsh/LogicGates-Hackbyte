//
//  CreateAccountResponseModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation

// MARK: - CreateAccountResponseModel
struct CreateAccountResponseModel:Decodable {
    var success: Bool?
    var message: String?
    var user: CreateAccountUser?
    var authToken: String?
}

// MARK: - User
struct CreateAccountUser:Decodable {
    var name, email, username, password: String?
    var preferences, tags, posts: [String]?
    var userType, id: String?
    var experience: [String]?
    var v: Int?
}
