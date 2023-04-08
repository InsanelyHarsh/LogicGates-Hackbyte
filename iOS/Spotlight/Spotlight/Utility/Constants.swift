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
    case showDataRetrieval = "DID_DATA_RETRIEVAL_REQUIRED_USERDEFAULT_KEY" //show data retierval screen/msg(s) if data has to
}


struct Constants{
    static var userSessionKey:String = "CURRENT_USER_SESSION_KEY---[USER_DEFAULT_KEY]"

    static var teacherLoginToken:String = "TEACHER_LOGIN_TOKEN"
    
    
    static var baseURL:String = "https://edp-project.vercel.app/"
    
    static var lastClassAttendanceDetail:String = "LAST_CLASS_ATTENDANCE_DETAIL"
}


enum URLData:String{
    case login = "https://upasthit-backend.vercel.app/api/teacher/login"
    case forgotPassword = "https://upasthit-backend.vercel.app/api/teacher/forgotpassword"
    
    case createNewAccount = "https://upasthit-backend.vercel.app/api/teacher/createTeacher"
    case getTeacherDetails = "https://upasthit-backend.vercel.app/api/teacher/findTeacher"
    
    case createNewCourse = "https://upasthit-backend.vercel.app/api/course/createCourse"
    case editCourse = "https://upasthit-backend.vercel.app/api/course/editCourse"
}
