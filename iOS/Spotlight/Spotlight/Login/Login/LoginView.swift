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
            if(loginVM.isLoading){
                VStack(spacing: 15){
                    ProgressView("Almost There..")
                    
                    Button {
                        self.loginVM.isLoading = false
                        loginVM.loginTask.cancel()
                    } label: {
                        Text("Cancel")
                    }.buttonStyle(.bordered)

                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background{
                    Color.clear.ignoresSafeArea()
                }
            }
            
            VStack(spacing: 30){
                
                VStack(spacing:10){
                    CustomField(text: $loginVM.email, emptyField: "Email", fieldName: "Login", keyBoardType: .default) {
                        
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
                    loginVM.loginTask = Task{
                        await self.loginVM.login()
                        
                        if(loginVM.isValidCredentials){
                            self.loginFlowRouter.goToMainLoginView()
                            self.sessionManager.loginCompleted()
                        }
                    }
                }
                .bold()
                .frame(maxWidth: .infinity)
                .disabled(self.loginVM.isLoading)
                
                
                Spacer()
            }
            .padding(.vertical)
            .blur(radius: self.loginVM.isLoading ? 0.5 : 0)
        }
        .navigationTitle("Login")
        .alert(isPresented: $loginVM.showAlert){
            loginVM.alert
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView{
            
        }
    }
}
