//
//  CoreLogicClient.swift
//  CloudKart
//
//  Created by Mobilecoderz1 on 04/07/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

internal final class CoreLogicClient {
    
    let session:  Session!
    let decoder = JSONDecoder()
    init() {
        let logger = Logger()
        session = Session(eventMonitors: [logger])
    }
    
    func requestWithParams<T: Decodable>(_ router: Router) -> Promise <T> {
        return Promise { seal in
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            session.request(router).responseDecodable(of: T.self, decoder: decoder) { (response) in
                switch response.result{
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}



