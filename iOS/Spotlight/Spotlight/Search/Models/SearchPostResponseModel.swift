//
//  SearchPostResponseModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation
import Foundation

// MARK: - SearchPostResponseModel
struct SearchPostResponseModel: Codable {
    var success: Bool?
    var posts: [SearchPost]?
    var message, error: String?
}

// MARK: - Post
struct SearchPost: Codable {
    var weight: Int?
    var postID, title: String?

    enum CodingKeys: String, CodingKey {
        case weight
        case postID = "postId"
        case title
    }
}
