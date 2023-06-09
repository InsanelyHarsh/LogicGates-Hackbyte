//
//  TabManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation


///Handles Tab of Application
class TabManager:ObservableObject{
    @Published var currentTab:TabRoutes = .search
    
    func changeTab(to newTab:TabRoutes){
        self.currentTab = newTab
    }
}
