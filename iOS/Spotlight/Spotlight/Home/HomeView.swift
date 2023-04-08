//
//  HomeView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import AVKit

struct HomeView: View {
    var videoURL:String = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                
                let size = proxy.size
                
                TabView{
                    ForEach(FeedList,id:\.id){ feed in
                        ZStack{
                            if(homeVM.isLoading){
                                ProgressView("Getting Your Feed")
                            }
                            else{
                                FeedPlayerView(feed: feed, player: homeVM.player)
                            }
                        }
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all,edges: .top)
                        .tag(feed.id)
                        .onAppear{
                            homeVM.getFeed(for: feed.feedLink)
                        }
                        .onDisappear{
                            homeVM.player.pause()
                        }
                    }
                }
                .rotationEffect(.init(degrees: 90))
                .frame(width: size.height)
                .tabViewStyle(.page)
                .frame(width: size.width)
            }
        }
//        .ignoresSafeArea(.all,edges: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
