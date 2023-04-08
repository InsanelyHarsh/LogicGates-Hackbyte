//
//  ForgotPasswordViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
class ForgotPasswordViewModel:ObservableObject{
    @Published var registeredEmail:String = ""
    
//    @Published var newPassword:String = ""
//    @Published var newConfirmPassword:String = ""

//    @Published var showAlert:Bool = false
//    @Published var alert:CustomErrorAlerts = LoginAlerts.invalidEmail
    
    
    @Published var isLoading:Bool = false
    let authenticator = Authenticator.shared
    let networkingService = NetworkingService()
    
    
    
    
    var isValidEmail:Bool{
        get{
            return self.authenticator.isValidEmail(registeredEmail)
        }
    }
    
    func updatePassword() async{
        
    }
    
    
    
    
//    var isValidNewPassword:Bool{
//        get{
//            return self.authenticator.isValidPassword(password: self.newPassword, confirmPassword: self.newConfirmPassword)
//        }
//    }
    
//    func updatePassword() async {
//        if(isValidNewPassword){
//            //TODO: Make API Request
//
//            do{
//                let response = try await self.networkingService.postJSON(url: URLData.forgotPassword.rawValue, requestData: ForgotPasswordRequestModel(email: self.registeredEmail), responseType: ForgotPasswordResponseModel.self)
//            }catch(_){
//
//            }
//        }else{
//            if(self.newPassword.count < 8){
//                self.alert = .invalidPassword
//                self.showAlert = true
//            }else{
//                self.alert = .mismatchPass
//                self.showAlert = true
//            }
////            self.showAlert = true
//        }
//    }
}
