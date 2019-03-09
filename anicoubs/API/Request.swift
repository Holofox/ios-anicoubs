//
//  Request.swift
//  anicoubs
//
//  Created by Holofox on 09.03.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Alamofire
import PromiseKit

class Request {
    
    @discardableResult
    public static func perform<T:Decodable>(route: URLRequestConvertible, decoder: JSONDecoder = JSONDecoder()) -> Promise<T> {
        return Promise { completion in
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion.fulfill(value)
                case .failure(let error):
                    completion.reject(error)
                }
            })
        }
    }
    
}
