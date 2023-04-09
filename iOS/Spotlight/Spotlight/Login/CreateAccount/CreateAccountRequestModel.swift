//
//  CreateAccountRequestModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation


// MARK: - CreateAccountRequestModel

struct CreateAccountRequestModel: Encodable {
    let name, username, email, password: String
    let userType: String
}
