//
//  HomeViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import AVKit


class HomeViewModel:ObservableObject{
    @Published var player:AVPlayer!
    @Published var isLoading:Bool = true
    
    func getFeed(for urlString:String){
        guard let url = URL(string: urlString) else {
            isLoading = true
            return
        }
        
        player = AVPlayer(url: url)
        player.play()
        isLoading = false
    }
    
    func playPauseFeed(){
        
    }
}
