//
//  ForgotPasswordView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var forgotPasswordVM:ForgotPasswordViewModel = ForgotPasswordViewModel()
    let action:()->Void
    
    @State var isSecured:Bool = true
    @State var isConfirmSecured:Bool = true
    var body: some View {
        VStack(spacing: 25){
            VStack(spacing: 10){
                CustomField(text: $forgotPasswordVM.registeredEmail, emptyField: "Enter your Email", fieldName: "Registered Email", keyBoardType: .default) {
                    
                }

            }.padding(.vertical)
            
            CustomButton(isPrimary: true, buttonTitle: "Update Password") {
                if(self.forgotPasswordVM.isValidEmail){
                    Task{
                        await self.forgotPasswordVM.updatePassword()
                    }
                    //                    action()
                }
            }
            .bold()
        
            
            Spacer()
        }
        .navigationTitle("Forgot Password")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView{
            
        }
    }
}
