//
//  TabRoutes.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation


enum TabRoutes:Hashable{
    case home
    case search
    case upload
    case settting
    case profile
    
    
    var navTitle:String{
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .upload:
            return "Upload"
        case .settting:
            return "Setting"
        case .profile:
            return "Profile"
        }
    }
}
