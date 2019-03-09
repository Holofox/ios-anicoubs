//
//  VideoModel.swift
//  anicoubs
//
//  Created by Holofox on 07.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

struct VideoModel: Decodable {
    
    struct Save: Decodable {
        let response: Response
    }
    
    struct Delete: Decodable {
        let response: UInt8?
    }
    
    struct Response: Decodable {
        let uploadUrl: String?
        let videoId: Int?
        let ownerId: Int?
        let title: String?
        let description: String?
        let accessKey: String?
    }
}
