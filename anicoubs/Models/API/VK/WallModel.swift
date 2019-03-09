//
//  WallModel.swift
//  anicoubs
//
//  Created by Holofox on 22.01.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

struct WallModel {
    
    struct Response: Decodable {
        let items: [Items]
        let count: Int
        let groups: [Groups]
    }
    
    struct Groups: Decodable {
        let photo200: String?
        let isClosed: UInt8?
        let photo50: String?
        let id: Int?
        let name: String?
        let photo100: String?
        let screenName: String?
        let type: String?
    }
    
    struct Items: Decodable {
        let markedAsAds: UInt8?
        let attachments: [Attachments]
        let fromId: Int?
        let isFavorite: Bool?
        let views: Views?
        let comments: Comments?
        let canEdit: UInt8?
        let ownerId: Int?
        let date: Date?
        let postType: String?
        let canPin: UInt8?
        let id: Int?
        let canDelete: UInt8?
        let postponedId: Int?
        let text: String?
        let createdBy: Date?
        let likes: Likes?
    }
    
    struct Views: Decodable {
        let count: Int?
    }
    
    struct Comments: Decodable {
        let count: Int?
        let canPost: UInt8?
        let canClose: UInt8?
        let groupsCanPost: Bool?
    }
 
    struct Attachments: Decodable {
        let video: Video?
        let type: String?
    }
    
    struct Video: Decodable {
        let description: String?
        let duration: Int?
        let accessKey: String?
        let photo320: String?
        let canEdit: UInt8?
        let date: Date?
        let platform: String?
        let views: Int?
        let comments: Int?
        let canAdd: UInt8?
        let title: String?
        let ownerId: Int?
        let photo800: String?
        let id: Int?
        let photo640: String?
        let photo130: String?
        let isFavorite: Bool?
    }
    
    struct Reposts: Decodable {
        let count: Int?
        let userReposted: String?
    }
    
    struct Likes: Decodable {
        let count: Int?
        let canLike: UInt8?
        let canPublish: UInt8?
        let userLikes: Int?
    }
    
}
