//
//  MainLoginView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct MainLoginView: View {
    
    @StateObject var loginFlowRouter:LoginFlowRouteManager = LoginFlowRouteManager()
    @EnvironmentObject var sessionManager:SessionManager
    
    var body: some View {
        NavigationStack(path: $loginFlowRouter.loginFlowRoutingPath) {
            VStack(spacing: 90){
                
                Text("Don't hold back!")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                VStack{
                    
                    CustomButton(buttonTitle: "Continue your Great Journey"){
                        self.loginFlowRouter.navigationTo(.login)
                    }
                    .bold()
                    
                    CustomDivider()
                    
                    
                    CustomButton(isPrimary: false,buttonTitle: "Start New Journey"){
                        self.loginFlowRouter.navigationTo(.createNewAccount)
                    }
                    .bold()

                }

                
                Spacer()
                
                
            }
            .environmentObject(loginFlowRouter)
            
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationDestination(for: LoginRoutes.self){ state in
                switch state{
                case .login:
                    
                    LoginView{
                        self.loginFlowRouter.goToMainLoginView()
                        self.sessionManager.loginCompleted()
                    }
                    .environmentObject(loginFlowRouter)
                    
                    
                case .forgotPassword:
                    
                    ForgotPasswordView{
                        withAnimation {
                            self.loginFlowRouter.goBack()
                        }
                    }

                    
                case .createNewAccount:
                    
                    CreateAccountView{
                        self.loginFlowRouter.goToMainLoginView()
                        self.sessionManager.loginCompleted()
                    }
                }
            }
        }
    }
}

struct MainLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoginView()
    }
}
