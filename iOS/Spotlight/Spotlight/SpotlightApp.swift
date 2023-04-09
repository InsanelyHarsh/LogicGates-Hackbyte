//
//  SpotlightApp.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import FirebaseCore
import AVKit
import WebKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()

    return true
  }
}
@main
struct SpotlightApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
//            RootView()
            ContentView()
        }
    }
}

struct ContentView: View {
   let player = AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/hackbyte-f169a.appspot.com/o/posts%2Ftest?alt=media&token=ab5c2ed3-df9f-4672-93ee-5e0e6414c0bf")!)
   var body: some View {
       RootView()
   }
}


struct YoutubeVideoView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let path = "https://firebasestorage.googleapis.com/v0/b/hackbyte-f169a.appspot.com/o/posts%2Ftest?alt=media&token=ab5c2ed3-df9f-4672-93ee-5e0e6414c0bf"
        guard let url = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
