//
//  FeedPlayer.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import AVKit


struct FeedPlayer:UIViewControllerRepresentable{
    @Binding var isPlaying:Bool
    
    var player:AVPlayer

    init(isPlaying: Binding<Bool>, player: AVPlayer) {
        self._isPlaying = isPlaying
        self.player = player
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()

        controller.player = player
        controller.showsPlaybackControls = false
        controller.player?.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if(isPlaying){
            uiViewController.player?.pause()
        }else{
            uiViewController.player?.play()
        }
    }
    
    
    class Coordinator:NSObject{
        var parent:FeedPlayer
        
        init(parent:FeedPlayer){
            self.parent = parent
        }
        
        @objc func restartPlayback(){
            
        }
    }
    typealias UIViewControllerType = AVPlayerViewController
    
    
}
//struct FeedPlayer:UIViewControllerRepresentable{
//
//    var player:AVPlayer
//
//    init(player: AVPlayer) {
//        self.player = player
//    }
//
//    func makeCoordinator() -> () {
////        return Coordinator(parent: self)
//    }
//    func makeUIViewController(context: Context) -> some UIViewController {
//        let controller = AVPlayerViewController()
//
//        controller.player = player
//        controller.showsPlaybackControls = false
//        controller.player?.actionAtItemEnd = .none
//
//        return controller
//    }
//
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//
//    }
//}
