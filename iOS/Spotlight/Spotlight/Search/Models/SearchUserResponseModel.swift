//
//  SearchUserResponseModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation

struct SearchUserResponseModel:Decodable {
    var success: Bool?
    var users: [SearchUser]?
    var message, error: String?
}

// MARK: - User
struct SearchUser:Decodable {
    var weight: Int?
    var userID, name, username: String?
}
