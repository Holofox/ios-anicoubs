//
//  RequestConverter.swift
//  anicoubs
//
//  Created by Holofox on 25.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import Alamofire

protocol RequestConverterProtocol: URLRequestConvertible {
    var method: HTTPMethod {get set}
    var route: String {get set}
    var parameters: Parameters {get set}
}

struct RequestConverter: RequestConverterProtocol {
    
    var method: HTTPMethod
    var route: String
    var basePath: String
    var parameters: Parameters = [:]
    
    init(method: HTTPMethod, basePath: String, route: String, parameters: Parameters = [:]) {
        self.method = method
        self.basePath = basePath
        self.route = route
        self.parameters = parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try basePath.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(route))
            urlRequest.httpMethod = method.rawValue
        
        // Debug
        print(urlRequest)
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
