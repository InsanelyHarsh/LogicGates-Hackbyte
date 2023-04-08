//
//  UploadView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct UploadView: View {
    @StateObject var uploadVM = UploadViewModel()
    var body: some View{
//        NavigationStack{
            uploadVM.feedImage
//        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
