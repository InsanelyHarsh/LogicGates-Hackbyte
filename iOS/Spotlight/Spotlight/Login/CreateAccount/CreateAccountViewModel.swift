//
//  CreateAccountViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
class CreateAccountViewModel:ObservableObject{
    @Published var name:String = "Harsh"
    @Published var email:String = "harsh@gmail.com"
    
    @Published var password:String = "Harsh@043"
    @Published var confirmPassword:String = "Harsh@043"
    
//    @Published var showAlert:Bool = false
//    @Published var alert:CustomErrorAlertProtocol = LoginAlerts.userAlreadyExist
    
    @Published var isValidCredentials:Bool = false
    
    let authenticator = Authenticator.shared
    let networkingService = NetworkingService()
//    let realmManager = RealmManager.shared
    
    @Published var isLoading:Bool = false
    
    var validPass:Bool{
        get{
            return self.authenticator.isValidPassword(password: self.password, confirmPassword: self.confirmPassword)
        }
    }
    
    var validEmail:Bool{
        get{
            return self.authenticator.isValidEmail(self.email)
        }
    }
    
    func createAccount() async {
        
    }
}
