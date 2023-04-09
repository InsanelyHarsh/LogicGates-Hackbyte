//
//  LoginViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import SwiftUI

class LoginViewModel:ObservableObject{
    @Published var email:String = "harsh@gmail.com"
    @Published var password:String = "Harsh@043"
    
    @Published var isValidCredentials:Bool = false
    
    @Published var showAlert:Bool = false
    @Published var alert:Alert = Alert(title: Text("...."))
    var loginTask : Task<(), Never>!
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
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        if(validPass && validEmail){
            //api call
            
            do{
                let loginResponse = try await networkingService.postJSON(url: URLData.login.rawValue, requestData: LoginRequestModel(email: email, password: password), responseType: LoginResponseModel.self)
                
                guard loginResponse.success != nil else { return }
                
                if(loginResponse.success!){
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isValidCredentials = true
                    }
                }else{
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.presentAlert(title: "Failed",description: loginResponse.message ?? "Try Again")
                    }
                }
            }
            catch{
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.presentAlert(title: "Unkown Error", description: "Try Again")
                }
            }
        }else{
            //show alert
            DispatchQueue.main.async {
                self.isLoading = false
                self.presentAlert(title: "Invalid Input", description: "Enter Valid Email & Password")
            }
        }
    }
}

extension LoginViewModel{
    private func presentAlert(title:String,description:String = ""){
        loginTask.cancel()
//        DispatchQueue.main.async {
        self.showAlert = true
        self.alert = Alert(title: Text(title), message: Text(description),dismissButton: .cancel{
            self.showAlert = false
        })
//        }
    }
}
