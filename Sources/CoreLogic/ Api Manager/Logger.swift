//
//  Logger.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 26/07/20.
//  Copyright © 2020 Admin. All rights reserved.
//
import Alamofire
import Foundation
final class Logger: EventMonitor {
    init() {
        
    }
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️⚡️ Body Data: \(body)
        """
        Console.log("requestDidResume \(message)")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
       // Console.log("⚡️⚡️⚡️⚡️⚡️ didParseResponse \(response.debugDescription)")
        Console.log("Status Code; \(response.response?.statusCode)")
        Console.log("⚡️⚡️⚡️⚡️⚡️ didParseResponse \(logResponse(data: response.data))")
        
    }
    func logResponse(data:Data?) {
        guard let dataValue = data else {
            return
        }
        do{
            let json = try JSONSerialization.jsonObject(with: dataValue, options: .allowFragments)
            Console.log(prettyPrintDict(with: json, responseData: dataValue))
        }catch{
            Console.log(error.localizedDescription)
            Console.log(String(data: dataValue, encoding: .utf8))
        }
        
    }
    func prettyPrintDict(with json: Any, responseData: Data) -> String{
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let string = String(data: data, encoding: String.Encoding.utf8)
            if let string  = string{
                return string
            }
        }catch{
            Console.log(error.localizedDescription)
            return String(data: responseData, encoding: .utf8) ?? ""
        }
        return ""
    }
}
