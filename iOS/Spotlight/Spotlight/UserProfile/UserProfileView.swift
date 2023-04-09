//
//  UserProfileView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import SwiftUI

struct UserProfileView: View {
    var userInfo:UserInfo
    @State var size:CGSize = CGSize()
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader{ g in
                let x = g.size
                Color.clear.ignoresSafeArea()
                    .onAppear{
                        size = x
                    }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading,spacing: 20){
                    
                    HStack(spacing: 30){
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: size.width*0.2, height: size.width*0.2)
                        VStack(alignment: .leading){
                            Text(userInfo.name)
                            
                            Text(userInfo.userName)
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    .font(.title2)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                    .padding(.bottom,5)
                    .background(Color.white)
                    
                    
                    VStack{
                        CustomlabeledContent(title: "Profession", description: "Actor")
                        CustomlabeledContent(title: "Experence", description: "3 Months")
                        CustomlabeledContent(title: "Availablibility", description: "Open to Collaborate")
                        CustomlabeledContent(title: "Study", description: "NSD School")
                        
                        
                        CustomlabeledContent(title: "Contact", description: userInfo.email)
                    }
                    
                    Divider()
                    
                    Text("Portfolio")
                        .font(.title2)
                        .frame(maxWidth: .infinity,alignment:.center)
                        .bold()
                    
                    
                        
                    VStack{
                        ForEach(0..<2){ _ in
                            Grid(alignment: .center) {
                                GridRow(alignment: .center){
                                    Rectangle()
                                        .foregroundColor(.red)
                                        .cornerRadius(8)
                                    
                                    Rectangle()
                                        .foregroundColor(.green)
                                        .cornerRadius(8)
                                }
                            }
                            .frame(height: size.height*0.45)
                        }
                    }
                
                    Spacer()
                }
                .padding(.horizontal)
//                .padding(.top,90)
            }
        }
        .navigationTitle("User Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func CustomlabeledContent(title:String,description:String)->some View{
        HStack{
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(description)
        }
        .font(.headline)
//        .padding(.horizontal)
        .padding(.vertical,5)
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
