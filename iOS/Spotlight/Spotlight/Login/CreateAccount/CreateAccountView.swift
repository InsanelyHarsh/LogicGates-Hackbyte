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
        
        ZStack(alignment: .center){
            
            if(createAccountVM.isLoading){
                VStack(spacing: 15){
                    ProgressView("Almost There..")
                    
                    Button {
                        self.createAccountVM.isLoading = false
                        createAccountVM.creatAccountTask.cancel()
                    } label: {
                        Text("Cancel")
                    }.buttonStyle(.bordered)

                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background{
                    Color.clear.ignoresSafeArea()
                }
            }
            
            VStack(spacing: 40){
                
                VStack(spacing: 25){
                    VStack{
                        CustomField(text: $createAccountVM.name, emptyField: "Enter Your Name", fieldName: "Name")
                        
                        CustomField(text: $createAccountVM.userName, emptyField: "username", fieldName: "Username")
                        
                        CustomField(text: $createAccountVM.email, emptyField: "Enter Your Email", fieldName: "Email", keyBoardType: .emailAddress)
                    }
                    

                    VStack{
                        CustomPasswordField(text: $createAccountVM.password, emptyField: "Enter Password", fieldName: "Password")
                        
                        CustomPasswordField(text: $createAccountVM.confirmPassword, emptyField: "Enter Password", fieldName: "Confirm Password")
                        
                    }.textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                }

                
                CustomButton(buttonTitle: "Create New Account") {
                    createAccountVM.creatAccountTask = Task {
                        await self.createAccountVM.createAccount()
                        if(createAccountVM.isValidCredentials){
                            action()
                        }
                    }
                }
                
                Spacer()
            }.blur(radius: self.createAccountVM.isLoading ? 2 : 0)
        }
        .alert(isPresented: $createAccountVM.showAlert, content: {
            createAccountVM.alert
        })
        .navigationTitle("Greatness is Comming")
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView{
            
        }
    }
}
