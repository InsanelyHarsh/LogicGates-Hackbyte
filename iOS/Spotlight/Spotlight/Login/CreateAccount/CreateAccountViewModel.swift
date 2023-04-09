//
//  CreateAccountViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import SwiftUI

class CreateAccountViewModel:ObservableObject{
    @Published var name:String = "Harsh"
    @Published var userName:String = "amiharsh_"
    @Published var email:String = "harsh@gmail.com"
    
    @Published var password:String = "Harsh@043"
    @Published var confirmPassword:String = "Harsh@043"
    
    @Published var showAlert:Bool = false
//    @Published var alert:CustomErrorAlertProtocol = LoginAlerts.userAlreadyExist
    var creatAccountTask : Task<(), Never>!
    @Published var alert:Alert = Alert(title: Text("...."))
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
        if(validPass && validEmail){
            DispatchQueue.main.async {
                self.isLoading = true
            }
            do{
                let createAccountResponse = try await networkingService.postJSON(url: URLData.createNewAccount.rawValue, requestData:
                                                                                    CreateAccountRequestModel(name: name, username: userName, email: email, password: password, userType: "creater"), responseType: CreateAccountResponseModel.self)
                
                
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                if(createAccountResponse.success == nil || createAccountResponse.success == false){
                    DispatchQueue.main.async {
                        self.presentAlert(title: "Error", description: createAccountResponse.message ?? "Please Try Again")
                    }
                }else{
                    //Save Data
                    UserRecordManager.saveUserRecord(info:  UserInfo(userName: createAccountResponse.user?.username ?? "--",
                                                                     name: createAccountResponse.user?.name ?? "--",
                                                                     email: createAccountResponse.user?.email ?? "--",
                                                                     authToken: createAccountResponse.authToken ?? "--",
                                                                     userType: createAccountResponse.user?.userType == "recruiter" ? .recruiter : .creater))
                    
                    
                    //Proceed
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.isValidCredentials = true
                    }
                }
            }catch{
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.presentAlert(title: "Unkown Error", description: "Try Again")
                }
            }
        }else{
            DispatchQueue.main.async {
                self.isLoading = false
                self.presentAlert(title: "Invalid Input", description: "Enter Valid Email & Password")
            }
        }
    }
}

extension CreateAccountViewModel{
    private func presentAlert(title:String,description:String = ""){
        if(self.creatAccountTask != nil){
            creatAccountTask.cancel()
        }
        self.showAlert = true
        self.alert = Alert(title: Text(title), message: Text(description),dismissButton: .cancel{
            self.showAlert = false
        })
    }
}

