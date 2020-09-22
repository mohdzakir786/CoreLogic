//
//  Router.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 10/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import Alamofire
import UIKit
public enum Router {
    public typealias Params = [String: Any]
    case authenticate(params: Params)
    case matchAddress(params: Params)

}

extension Router:  Alamofire.URLRequestConvertible {
    
    public func asURLRequest () throws -> URLRequest {
        let config = self.requestConfig
        var baseURL: URL {
            switch self {
            case .authenticate:
                return URL(string: "https://access-api.corelogic.asia/access/oauth")!
            default:
                return URL(string: "https://api-uat.corelogic.asia/sandbox")!
            }
        }
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(config.path))
        urlRequest.httpMethod = config.method.rawValue
        
        if let token =  CoreLogicServices.shared.getAuthToken()?.accessToken{
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let params = config.params, params.count > 0 {
            switch config.method {
            case .get:
                var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponents.url!
                return urlRequest
            default:
                return try JSONEncoding.default.encode(urlRequest, with: params)
            }
        } else {
            return try JSONEncoding.default.encode(urlRequest)
        }
    }
 
}

extension Router {
    var requestConfig: (path: String, params: Params?, method: Alamofire.HTTPMethod) {
        switch self {
        case .authenticate(let params):
            return ("/token", params, .get)
        case .matchAddress(let params):
              return ("search/au/matcher/address", params, .get)
        }
    }
}
