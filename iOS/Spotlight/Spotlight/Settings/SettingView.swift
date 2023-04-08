//
//  SettingView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var sessionManager:SessionManager
    var body: some View {
        VStack{
            List {
                Text("Privacy Terms")
                Button {
                    sessionManager.signOut()
                } label: {
                    Text("Log out")
                        .foregroundColor(.red)
                }

            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
