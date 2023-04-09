//
//  SearchView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM:SearchViewModel = SearchViewModel()
    var body: some View {
        VStack{
            if(searchVM.searchQuery.isEmpty){
                VStack{
                    Image(systemName: "sparkle.magnifyingglass")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.4)
                    
                    Text("Spot Talent!")
                }
            }else{
                
                
                
                List{
                    Picker("What is your favorite color?", selection: $searchVM.searchCategory) {
                        ForEach(SearchCategory.allCases,id:\.self){ category in
                            Text(category.title)
                                .tag(category)
                                .onTapGesture {
                                    Logger.logLine()
                                    Logger.logMessage(category.title)
                                    Logger.logLine()
                                }
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    ForEach(searchVM.searchResult,id:\.self) { value in
                        NavigationLink(value: "userprofileview"){
                            Text(value)
                        }
                    }
                }.listStyle(.plain)
            }
        }
        .task {
            await searchVM.makeSearchQuery()
        }
        .onChange(of: searchVM.searchCategory, perform: { newValue in
            Task{
                await searchVM.makeSearchQuery()
            }
        })
        .navigationDestination(for: String.self, destination: { value in
            if(value == "userprofileview"){
                UserProfileView(userInfo: UserRecordManager.dummyData)
            }
        })
        .searchable(text: $searchVM.searchQuery, placement: .navigationBarDrawer, prompt: Text("Search"))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SearchView()
        }
    }
}
