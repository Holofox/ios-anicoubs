//
//  CoubChannelModel.swift
//  anicoubs
//
//  Created by Holofox on 23.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Foundation

struct CoubChannelModel : Decodable {
    
    let id: Int
    let permalink: String
    let title: String
    let description: String?
    let followersCount: Int
    let followingCount: Int
    // let avatarVersions: Versions
    let coubsCount: Int
    let recoubsCount: Int
}
