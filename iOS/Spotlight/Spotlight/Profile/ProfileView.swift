//
//  ProfileView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            UserProfileView(userInfo: UserRecordManager.getUserRecord)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }

                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }

                    }
                }
                .tint(.black)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
