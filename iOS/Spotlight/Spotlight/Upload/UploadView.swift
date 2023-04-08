//
//  UploadView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct UploadView: View {
    @State var captureMedia:Bool = false
    var body: some View{
        VStack{
            Text("Show Your Talent")
                .font(.largeTitle)
                .bold()
            
            
            HStack{
                Spacer()
                
                CustomButton(buttonTitle: "Capture Media") {
                    captureMedia.toggle()
                }
                
                Spacer()
                
                CustomButton(isPrimary: false, buttonTitle: "Upload Media") {
                    
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $captureMedia) {
            UploadMediaView()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
