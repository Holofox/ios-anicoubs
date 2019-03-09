//
//  ServerInfoModel.swift
//  anicoubs
//
//  Created by Holofox on 23.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

struct ServerInfoModel : Decodable {
    
    let response : Response
    
    struct Response : Decodable {
        let repository: Int
        let backupRepository: Int
        let version: String
    }
}
