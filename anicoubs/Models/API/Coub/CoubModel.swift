//
//  CoubModel.swift
//  anicoubs
//
//  Created by Holofox on 23.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Foundation

struct CoubModel : Decodable {

    let id: Int
    let type: String
    let permalink: String
    let title: String
    let channelId: Int
    let createdAt: Date
    let updatedAt: Date
    let viewsCount: Int
    let reversed: Bool
    let originalSound: Bool
    let hasSound: Bool
    // let fileVersions:
    // let audioVersions:
    // let imageVersions:
    // let firstFrameVersions:
    let audioFileUrl: String?
    let channel: CoubChannelModel
    let picture: String
    let timelinePicture: String
    let smallPicture: String
    let percentDone: Double
    let tags: [Tags]
    let categories: [Categories]
    let recoubsCount: Int
    let remixesCount: Int
    let likesCount: Int
    let uploadedByIosApp: Bool
    let uploadedByAndroidApp: Bool
    // let mediaBlocks:
    let duration: Double
    let audioCopyrightClaim: String?

    struct Tags: Decodable {
        let id: Int
        let title: String
        let value: String
    }
    
    struct Categories: Decodable {
        let id: Int
        let title: String
        let permalink: String
    }
    
}
