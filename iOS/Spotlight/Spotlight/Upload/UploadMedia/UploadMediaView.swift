//
//  UploadMediaView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import PhotosUI
struct UploadMediaView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var uploadMediaVM:UploadMediaViewModel = UploadMediaViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                if let picker = uploadMediaVM.picker{
                    //show selected media
                }
                Spacer()
                PhotosPicker(selection: $uploadMediaVM.picker,matching: .videos) {
                    HStack{
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                        
                        Text("Upload Media")
                    }
                }
                .buttonStyle(.borderless)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Show Talent")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }.tint(.black)
                }
            }
        }
    }
}

struct UploadMediaView_Previews: PreviewProvider {
    static var previews: some View {
        UploadMediaView()
    }
}
