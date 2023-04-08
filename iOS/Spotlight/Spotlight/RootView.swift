//
//  RootView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct RootView: View {
    @StateObject private var sessionManager:SessionManager = SessionManager()
//    let realmManager:RealmManager = RealmManager.shared
    
    var body: some View {
        ZStack{
            switch sessionManager.currentState{
            case .loggedIn:
                
                MainView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
                
            case .loggedOut:
                
                MainLoginView()
                    .transition(.opacity)
                    .environmentObject(sessionManager)
                
            case .onBoarding:
                
                GeometryReader{ g in
                    OnBoardingView(screenSize: g.size){
                        sessionManager.signOut()  //User Completed OnBoarding
                    }
                }
                .transition(.opacity)
                .environmentObject(sessionManager)
            }
        }
        .onAppear{
            self.sessionManager.configureCurrentState()
            
//            realmManager.launchRealm()
//            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
