//
//  LoginView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginVM:LoginViewModel = LoginViewModel()
    @EnvironmentObject var loginFlowRouter:LoginFlowRouteManager
    @EnvironmentObject var sessionManager:SessionManager
    
    @State var isSecured:Bool = true
    
    let action:()->Void
    var body: some View {
        ZStack{
            VStack(spacing: 30){
                
                VStack(spacing:10){
                    CustomField(text: $loginVM.email, emptyField: "EMail", fieldName: "Login", keyBoardType: .default) {
                        
                    }
                    
                    
                    CustomField(text: $loginVM.password, emptyField: "Password", fieldName: "Password", keyBoardType: .default) {
                        
                    }
                }
                
                HStack{
                    Spacer()

                    Button {
                        self.loginFlowRouter.navigationTo(.forgotPassword)
                    } label: {
                        Text("Forgot Password?")
                            .underline()
                            .font(.subheadline)
                    }.padding(.trailing,15)
                        .tint(.gray)
                }
                .padding(.top,-20)
                
                
                
                CustomButton(buttonTitle: "Login") {
//                    Task{
//                        await self.loginVM.login()
//                    }
                    self.loginFlowRouter.goToMainLoginView()
                    self.sessionManager.loginCompleted()
                }
                .bold()
                .frame(maxWidth: .infinity)
                .disabled(self.loginVM.isLoading)
                
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Login")


    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView{
            
        }
    }
}
