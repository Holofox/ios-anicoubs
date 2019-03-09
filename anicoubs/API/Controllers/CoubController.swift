//
//  CoubController.swift
//  anicoubs
//
//  Created by Holofox on 23.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Alamofire
import PromiseKit

class CoubController {
    
    static var basePath: String {
        return "https://coub.com/api/v2/"
    }
    
    enum category {
        case coubs
    }
 
    class Coubs {
        static func get(permalink: String) -> Promise<CoubModel> {
            let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
            
            return Request.perform(route: RequestConverter(method: .get, basePath: basePath, route: "\(category.coubs)/\(permalink)"), decoder: decoder)
        }
    }
    
}
