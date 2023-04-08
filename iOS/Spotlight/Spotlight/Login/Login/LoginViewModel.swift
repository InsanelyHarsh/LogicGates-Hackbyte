//
//  LoginViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
class LoginViewModel:ObservableObject{
    @Published var email:String = "harsh@gmail.com"
    @Published var password:String = "Harsh@043"
    
    @Published var isValidCredentials:Bool = false
    @Published var retrieveData:Bool = false
    
    @Published var showAlert:Bool = false
//    @Published var alert:CustomErrorAlerts = LoginAlerts.invalidEmail
    
    let authenticator = Authenticator.shared
    let networkingService = NetworkingService()
    
    @Published var isLoading:Bool = false
    
    private var validPass:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.password)
        }
    }
    
    private var validEmail:Bool{
        get{
            return self.authenticator.isValidEmail(self.email)
        }
    }

    func login() async{
        if(validPass && validEmail){
            //api call
        }else{
            //show alert
        }
    }
}
