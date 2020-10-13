//
//  CoreLogicClient.swift
//  CoreLogicRealState
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
            session.request(router).validate(statusCode: 200..<300).responseDecodable(of: T.self, decoder: decoder) { (response) in
                switch response.result{
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(self.actualError(error: error, data: response.data, statusCode: response.response?.statusCode))
                }
            }
        }
    }
    func actualError(error: AFError, data: Data?, statusCode: Int?) -> Error{
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    return NSError(domain:"com.corelogic.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
                case .networkConnectionLost:
                    return NSError(domain:"com.corelogic.error", code:urlError.code.rawValue, userInfo:[ NSLocalizedDescriptionKey: "The Internet connection appears to be offline."])
                default:
                    
                    return error
                }
            }
        }else{
            if let data = data, let errorString = String(bytes:
                data, encoding: .utf8), let code = statusCode{
                if code == 401{
                    let model: CLAuthErrorResponse? = getModel(data: data)
                    let message = model?.messages.map({$0.message}).joined(separator: "\n")
                    return NSError(domain:"com.corelogic.error", code: code, userInfo:[ NSLocalizedDescriptionKey: message ?? errorString])
                }
                let model: CLErrorResponse? = getModel(data: data)
                let message = model?.errors.map({$0.msg}).joined(separator: "\n")
                return NSError(domain:"com.corelogic.error", code: code, userInfo:[ NSLocalizedDescriptionKey: message ?? errorString])
                
            }
        }
        return error

    }
    func getModel<T: Decodable>(object: Any) -> T?{
        do{
            let data = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
            return  try JSONDecoder().decode(T.self, from: data)
        }catch{
            print("\(error)")
        }
        return nil
    }
    
    func getModel<T: Decodable>(data: Data) -> T?{
          do{
              return  try JSONDecoder().decode(T.self, from: data)
          }catch{
              print("\(error)")
          }
          return nil
      }
}



