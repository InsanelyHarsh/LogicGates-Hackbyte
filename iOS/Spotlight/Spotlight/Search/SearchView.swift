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
                    
                    Text("Sport Talent!")
                }
            }else{
                List{
                    ForEach(searchResult,id:\.self) { value in
                        Text(value)
                    }
                }
            }
        }
        .searchable(text: $searchField, placement: .automatic, prompt: Text("Search"))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
