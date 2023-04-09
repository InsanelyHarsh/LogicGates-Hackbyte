//
//  Constants.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation

enum CurrentUserSession:String{
    case onBoarding = "ONBOARDING_USERDEFAULT_KEY" //Checks wheather user has seen onboarding or not.
    case login = "USER_LOGIN_USERDEFAULT_KEY" //Checks wheather user is logged in/out.
    case home = "HOME_USERDEFAULT_KEY"
}


struct Constants{
    static var userSessionKey:String = "CURRENT_USER_SESSION_KEY---[USER_DEFAULT_KEY]"

    static var userLoginToken:String = "USER_LOGIN_TOKEN"
    static var userNameKey:String = "USER_NAME_KEY"
    static var nameKey:String = "NAME_KEY"
    static var userEmailKey:String = "USER_EMAIL_KEY"
    static var userTypeKey:String = "USER_TYPE_KEY"
    
    static var baseURL:String = "https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app"
    
    static var lastClassAttendanceDetail:String = "LAST_CLASS_ATTENDANCE_DETAIL"
}


enum URLData:String{
    
    //https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app
    case login = "https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app/api/user/login"
    case createNewAccount = "https://logic-gates-hackbyte-1.vercel.app/api/user/create"
    
    case forgotPassword = "https://upasthit-backend.vercel.app/api/teacher/forgotpassword"
    
    ///auth Token in header
    case createPost = "https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app/api/post/create"
    
    ///id, auth in header
    case editPost = "https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app/api/post/editpost"
    
    ///id, auth in header
    case getPostByID = "https://logic-gates-hackbyte-1-git-main-janmesh799.vercel.app/api/post/getpost"
}
