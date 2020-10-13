//
//  Network.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 05/07/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import PromiseKit
import Foundation
struct Console{
    static func log(_ message: Any?){
        print(message ?? "Nothing to log")
        
    }
}
public protocol ApiInterface {
    func authenticate<CLAuthenticationModel: Decodable>() -> Promise<CLAuthenticationModel>
    func matchAddress<CLMatchAddressModel: Decodable>(params: [String: Any]) -> Promise<CLMatchAddressModel>
    func corePropertyAttributes<CLCoreProperyDetail: Decodable>(propertyId: Int) -> Promise<CLCoreProperyDetail>
    func propertyLocation<CLPropertyLocation: Decodable>(propertyId: Int) -> Promise<CLPropertyLocation>
    func places<CLSchoolPlace: Decodable>(localityId: Int) -> Promise<CLSchoolPlace>
    func schoolDetail<CLSchoolDetail: Decodable>(placeId: Int) -> Promise<CLSchoolDetail>
    
}

public final class CoreLogicServices: NSObject, ApiInterface {
    public func schoolDetail<CLSchoolDetail>(placeId: Int) -> Promise<CLSchoolDetail> where CLSchoolDetail : Decodable {
        client.requestWithParams(.schoolDetail(placeId: placeId))
    }
    
    public func places<CLSchoolPlace>(localityId: Int) -> Promise<CLSchoolPlace> where CLSchoolPlace : Decodable {
        client.requestWithParams(.places(localityId: localityId))
    }
    
    public func propertyLocation<CLPropertyLocation>(propertyId: Int) -> Promise<CLPropertyLocation> where CLPropertyLocation : Decodable {
        client.requestWithParams(.propertylocation(propertyId: propertyId))
    }
    
    public func corePropertyAttributes<CLCoreProperyDetail>(propertyId: Int) -> Promise<CLCoreProperyDetail> where CLCoreProperyDetail : Decodable {
        client.requestWithParams(.corePropertyAttributes(propertyId: propertyId))
    }
    
    public func matchAddress<CLMatchAddressModel>(params: [String : Any]) -> Promise<CLMatchAddressModel> where CLMatchAddressModel : Decodable {
        client.requestWithParams(.matchAddress(params: params))
    }
    
    public func authenticate<CLAuthenticationModel>() -> Promise<CLAuthenticationModel> where CLAuthenticationModel : Decodable {
        client.requestWithParams(.authenticate(params: getAuthParams()))
    }
    private let client = CoreLogicClient()
    fileprivate var config: CoreLogicConfig?
    public static let shared = CoreLogicServices()
    fileprivate var authToken: CLAuthenticationModel?
    fileprivate override init(){}
    public func initWith(config: CoreLogicConfig) {
        self.config = config
    }
    public func setAuth(token: CLAuthenticationModel){
        authToken = token
    }
    public func getAuthToken() -> CLAuthenticationModel?{
        return authToken
    }
    func getAuthParams() -> [String: Any]{
        var params = [String: Any]()
        params["client_id"] = config?.clientId
        params["client_secret"] = config?.clientSecret
        params["grant_type"] = "client_credentials"
        return params
    }
    
}
