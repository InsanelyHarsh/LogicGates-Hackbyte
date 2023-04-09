//
//  HomeView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import AVKit
/*
 Profile views
 Upload
 APIs
 searching
 */
struct HomeView: View {
    var videoURL:String = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    let player = AVPlayer(url: URL(string: "https://www.youtube.com/watch?v=q5D55G7Ejs8")!)
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    var body: some View {
        VStack{
            VideoPlayer(player: player)
//            VideoPlayer(player: AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/hackbyte-f169a.appspot.com/o/posts%2Ftest?alt=media&token=ab5c2ed3-df9f-4672-93ee-5e0e6414c0bf")!))
                
//            GeometryReader{ proxy in
//
//                let size = proxy.size
//
//                TabView{
////                    ForEach(FeedList,id:\.id){ feed in
//                        ZStack{
//                            if(homeVM.isLoading){
//                                ProgressView("Getting Your Feed")
//                            }
//                            else{
//                                FeedPlayerView(feed: FeedList.first!, player: homeVM.player)
//                            }
//                        }
//                        .frame(width: size.width)
//                        .rotationEffect(.init(degrees: -90))
//                        .ignoresSafeArea(.all,edges: .top)
//                        .tag("feed.id")
//                        .onAppear{
////                            homeVM.getFeed(for: feed.feedLink)
//                            homeVM.getFeed(for: FeedList.first!.feedLink)
//                        }
//                        .onDisappear{
//                            homeVM.player.pause()
//                        }
////                    }
//                }
//                .rotationEffect(.init(degrees: 90))
//                .frame(width: size.height)
//                .tabViewStyle(.page)
//                .frame(width: size.width)
//            }
        }
//        .ignoresSafeArea(.all,edges: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
