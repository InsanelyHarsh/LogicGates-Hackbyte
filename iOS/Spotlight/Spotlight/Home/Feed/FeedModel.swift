//
//  FeedModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation


struct FeedModel{
    let id = UUID().uuidString
    
    let userName:String
    let description:String
    let tags:[String]
    let likeCount:Int
    
    let commentCount:Int
    
    let feedLink:String
}


var FeedList:[FeedModel] = [
    .init(userName: "amiharsh_", description: "Took 15 hours to make this, really looking forward how to liked", tags: ["photography","nature","post","new"], likeCount: 100, commentCount: 69, feedLink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
    
        .init(userName: "janmesh799", description: "Great Morning Start!", tags: ["painting","oil","challenge","new"], likeCount: 69, commentCount: 10, feedLink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
    
        .init(userName: "insane", description: "Stretching my boundaries", tags: ["photography","nature","post","new"], likeCount: 13, commentCount: 5, feedLink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
]
