//
//  NewPostView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import SwiftUI

struct NewPostView: View {

    @StateObject var newPostVM:NewPostViewModel = NewPostViewModel()
    @State private var size:CGSize = CGSize()
    @State var showMediaSelection:Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    Color.clear.ignoresSafeArea()
                        .onAppear{
                            self.size = size
                        }
                }
                
                VStack{
                    
                    Rectangle()
                        .frame(width: size.width*0.98, height: size.width*0.7)
                        .foregroundColor(.gray)
                        .overlay {
                            Button {
                                showMediaSelection.toggle()
                            } label: {
                                Text("Select Media")
                            }
                            .foregroundColor(.white)
                        }
                    
                    CustomField(text: $newPostVM.postTitle, emptyField: "Post Title", fieldName: "Title")
                    
                    CustomField(text: $newPostVM.postDescription, emptyField: "Enter Description", fieldName: "Description")
                    
                    CustomField(text: $newPostVM.tagText, emptyField: "Enter Tags", fieldName: "Tags"){
                        newPostVM.addTag()
                    }
                    
                    HStack {
                        CustomTagView(rows: $newPostVM.rows) { id in
                            newPostVM.removeTag(by: id)
                        }
                    }
                    
                    
                    Spacer()
                    
                    CustomButton(buttonTitle: "Post") {
                        self.newPostVM.makePost()
                    }
                }
            }
            .confirmationDialog("Select a color", isPresented: $showMediaSelection, titleVisibility: .visible) {
                ForEach(NewPostMediaOptions.allCases, id: \.self) { mediaOption in
                    NavigationLink(value: mediaOption) {
                        Text(mediaOption.title)
                    }
                }
            }
            .navigationDestination(for: NewPostMediaOptions.self) { option in
                switch option{
                case .camera:
                    CaptureMediaView()
                case .upload:
                    UploadMediaView()
                }
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
