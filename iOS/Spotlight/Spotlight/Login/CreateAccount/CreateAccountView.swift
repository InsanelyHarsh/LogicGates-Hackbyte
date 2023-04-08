//
//  CreateAccountView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var createAccountVM:CreateAccountViewModel = CreateAccountViewModel()
    
    @State private var isSecured:Bool = true
    @State private var isConfirmSecured:Bool = true
    @State private var val:Double = 2020
    let action:()->Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(spacing: 40){
            
            VStack(spacing: 25){
                VStack{
                    CustomField(text: $createAccountVM.name, emptyField: "Enter Your Name", fieldName: "Name")
                    
                    CustomField(text: $createAccountVM.email, emptyField: "Enter Your Email", fieldName: "Email", keyBoardType: .emailAddress)
                }
                

                VStack{
                    CustomPasswordField(text: $createAccountVM.password, emptyField: "Enter Password", fieldName: "Password")
                    
                    CustomPasswordField(text: $createAccountVM.confirmPassword, emptyField: "Enter Password", fieldName: "Confirm Password")
                    
                }.textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

            }

            
            CustomButton(buttonTitle: "Create New Account") {
//                self.action()
                //self.signupVM.createAccount()
            }
            
            Spacer()
        }
        .navigationTitle("Greatness is Comming")
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView{
            
        }
    }
}
