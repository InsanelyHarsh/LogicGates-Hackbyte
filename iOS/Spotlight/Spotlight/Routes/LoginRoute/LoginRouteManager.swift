//
//  LoginRouteManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation



final class LoginFlowRouteManager:ObservableObject{
    
    @Published var loginFlowRoutingPath:[LoginRoutes] = []
    
    func goBack(){
        if(self.loginFlowRoutingPath.count>0){
            self.loginFlowRoutingPath.removeLast()
        }
    }
    
    func goToMainLoginView(){
        self.loginFlowRoutingPath = []
    }
    
    func navigationTo(_ state:LoginRoutes){
        self.loginFlowRoutingPath.append(state)
    }
}

