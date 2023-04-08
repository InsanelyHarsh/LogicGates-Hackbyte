//
//  UploadMediaView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct UploadMediaView: View {
    
    @StateObject private var uploadVM = UploadViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            VStack{
                if(uploadVM.isGranted){
                    if(uploadVM.feed != nil){
                        MediaPreview(preview: uploadVM.feed!, size: size)
                    }
                    else{
                        Color.purple.ignoresSafeArea()
                    }
                }
                else{
                    Color.red.ignoresSafeArea()
                }
            }
            .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .tint(.red)
                    .padding(15)
            }

        })
        .overlay(alignment: .bottom){
            HStack(){
                Button {
                    //cameraa
                } label: {
                    Image(systemName: "repeat.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                
                Spacer()
                
                Button {
                    withAnimation(.default){
                        uploadVM.isRecording.toggle()
                    }
                } label: {
                    Image(systemName: uploadVM.isRecording ? "record.circle.fill" : "record.circle" )
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(uploadVM.isRecording ? .red : .white)
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(systemName: "record.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .padding(.bottom,50)

        }
    .navigationTitle("Settings")
    .navigationBarTitleDisplayMode(.inline)
}
}

//struct UploadMediaView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadMediaView()
//    }
//}
