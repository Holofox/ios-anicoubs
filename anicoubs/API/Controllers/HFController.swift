//
//  HFController.swift
//  anicoubs
//
//  Created by Holofox on 09.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Alamofire
import PromiseKit

class HFController {
    
    static var basePath: String {
        return "https://holofox.ru/api/v1/method/"
    }
    
    enum category {
        case channels
        case utils
    }

    class Channels {
        static func get(channelId: Int) -> Promise<ChannelModel> {
            return Request.perform(route: RequestConverter(method: .get, basePath: basePath, route: "\(category.channels)/id/\(channelId)"))
        }
    }
    
    class Utils {
        static func serverSettings() -> Promise<ServerInfoModel> {
            let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
            return Request.perform(route: RequestConverter(method: .get, basePath: basePath, route: "\(category.utils)/serverSettings"), decoder: decoder)
        }
    }
    
}
