//
//  MainView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI

struct MainView: View {
    @State private var showProfile:Bool = false
    @StateObject var tabManager:TabManager = TabManager()
    var body: some View {
        NavigationStack{
            TabView{
                HomeView()
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .tag(TabRoutes.home)
                
                
                SearchView()
                    .tabItem {
                        VStack{
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                
                UploadView()
                    .tabItem {
                        VStack{
                            Image(systemName: "plus")
                            Text("Upload")
                        }
                    }
                    .tag(TabRoutes.upload)
                
                SettingView()
                    .tabItem {
                        VStack{
                            Image(systemName:"gear")
                            Text("Settings")
                        }
                    }
                    .tag(TabRoutes.settting)
            }
//            .tint(.white)
            .navigationTitle(tabManager.currentTab.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Image(systemName: "person.circle")
                        .onTapGesture {
                            self.showProfile.toggle()
                        }
                }
            }
            .sheet(isPresented: $showProfile){
                ProfileView()
            }

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
