//
//  UserRecordManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation



struct UserInfo{
    let userName:String
    let name:String
    let email:String
    let authToken:String
    let userType:UserType
}

enum UserType{
    case creater
    case recruiter
    
    var title:String{
        switch self {
        case .creater:
            return "Creater"
        case .recruiter:
            return "Recruiter"
        }
    }
}


final class UserRecordManager{
//    static var instance:UserRecordManager = UserRecordManager()
    
    static func saveUserRecord(info:UserInfo){
        DispatchQueue.main.async {
            UserDefaults.standard.set(info.name, forKey: Constants.nameKey)
            UserDefaults.standard.set(info.userName, forKey: Constants.userNameKey)
            UserDefaults.standard.set(info.email, forKey: Constants.userEmailKey)
            UserDefaults.standard.set(info.authToken, forKey: Constants.userLoginToken)
            UserDefaults.standard.set(info.userType.title, forKey: Constants.userTypeKey)
        }
    }
    
    static var getUserRecord:UserInfo{
        UserInfo(userName: UserDefaults.standard.string(forKey: Constants.userNameKey) ?? "-",
                 name: UserDefaults.standard.string(forKey: Constants.nameKey) ?? "-",
                 email: UserDefaults.standard.string(forKey: Constants.userEmailKey) ?? "-",
                 authToken: UserDefaults.standard.string(forKey: Constants.userLoginToken) ?? "-",
                 userType: UserDefaults.standard.string(forKey: Constants.userTypeKey) == "Recruiter" ? .recruiter : .creater)
    }
    
    static var dummyData:UserInfo{
        UserInfo(userName: "insanelyharsh",
                 name: "Mohan",
                 email: "weirdo@yahoo.com",
                 authToken: "DUMMY_DATA",
                 userType: UserType.creater)
    }
    
    static func removeAllData(){
        DispatchQueue.main.async {
            UserDefaults.standard.removeObject(forKey: Constants.nameKey)
            UserDefaults.standard.removeObject(forKey: Constants.userNameKey)
            UserDefaults.standard.removeObject(forKey: Constants.userLoginToken)
            UserDefaults.standard.removeObject(forKey: Constants.userEmailKey)
            UserDefaults.standard.removeObject(forKey: Constants.userTypeKey)
        }
    }
}
