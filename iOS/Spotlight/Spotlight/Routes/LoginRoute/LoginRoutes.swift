//
//  LoginRoutes.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation

enum LoginRoutes:Hashable{
    case login
    case createNewAccount
    case forgotPassword
    
    
    var navTitle:String{
        switch self {
        case .login:
            return "Login"
        case .createNewAccount:
            return "Create Account"
        case .forgotPassword:
            return "Forgot Password"
        }
    }
}

