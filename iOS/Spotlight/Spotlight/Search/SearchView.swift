//
//  SearchView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct SearchView: View {
    @State var searchField:String = ""
    @State var searchResult:[String] = ["amiharsh_","harsh","realHarsh01"]
    var body: some View {
        VStack{
            if(searchField.isEmpty){
                VStack{
                    Image(systemName: "sparkle.magnifyingglass")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.4)
                    
                    Text("Spot Talent!")
                }
            }else{
                List{
                    ForEach(searchResult,id:\.self) { value in
                        NavigationLink(value: "userprofileview"){
                            Text(value)
                        }
                    }
                }
            }
        }
        .navigationDestination(for: String.self, destination: { value in
            if(value == "userprofileview"){
                UserProfileView(userInfo: UserRecordManager.dummyData)
            }
        })
        .searchable(text: $searchField, placement: .automatic, prompt: Text("Search"))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
