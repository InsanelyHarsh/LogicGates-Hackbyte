//
//  FeedPlayerView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import AVKit
struct FeedPlayerView: View {
    var feed:FeedModel
    var player:AVPlayer
    @State private var isPlaying:Bool = false
    var body: some View {
        ZStack(alignment:.bottom){
//            GeometryReader{ proxy in
//                Color.clear
//            }
            Color.cyan.ignoresSafeArea()
            FeedPlayer(isPlaying: $isPlaying, player: player)
                .onTapGesture {
                    isPlaying.toggle()
                }
            
            VStack{
//                HStack{
//                    Image(systemName: "rays")
//                    
//                    Text("SpotLight")
//                }
//                .opacity(0.8)
//                Spacer()
                
                HStack{
                    Spacer()
                    
                    VStack(spacing: 30){
                        VStack{
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("\(feed.likeCount)")
                        }
                        
                        VStack{
                            Image(systemName: "message")
                            Text("\(feed.commentCount)")
                        }
                        
                        VStack{
                            Image(systemName: "bookmark")
                        }
                        
                        VStack{
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }
                }
                
                
                VStack(alignment:.leading,spacing: 20){
                    HStack{
                        Image(systemName: "person.circle.fill")
                        Text(feed.userName)
                    }
                    .font(.headline)
                    .foregroundColor(.gray)
                    
                    VStack(alignment:.leading,spacing: 8){
                        Text(feed.description)
                            .lineLimit(0)
                        
                        HStack(spacing:2){
                            ForEach(feed.tags,id:\.self){ tag in
                                Text("#\(tag)")
                            }
                        }
                            .foregroundColor(.gray)
                    }
                }
            }
//            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            .padding(.bottom,30)
        }
        .foregroundColor(.white)
    }
}

struct FeedPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        FeedPlayerView(feed: .init(userName: "amiharsh_", description: "Took 15 hours to make this, really looking forward how to liked",
                                   tags: ["photography","nature","post","new"], likeCount: 100, commentCount: 69,
                                   feedLink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
                       player: AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
        )
    }
}
