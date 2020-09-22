//
//  CommonResponse.swift
//  CloudKart
//
//  Created by Admin on 26/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct User: Decodable {
    let message: String?
    let code: Int?
    let data: UserData?
    let token: String?
    let count:Int?
    let address_ctr:Int?
    let errors:[ErrorModel]?
}
struct ErrorModel:Decodable {
    let message: String?
}


// MARK: - DataClass
struct UserData: Codable {
    let addr_streetNo:String?
    let addr_city:String?
    let addr_barangay:String?
    let addr_zipcode:String?
    let addr_barangayID:Int?
    let addr_cityID:Int?
    let addr_provinceID:Int?
    let gender:String?
    let custID, lname, fname, mname: String?
    let mobileNo:String?
    let bday:String?
    let email:String?
    let avatar:String?

}
public struct CLAuthenticationModel: Decodable {
    public init(accessToken: String, tokenType: String, expiresIn: Int, scope: String, iss: String, envAccessRestrict: Bool, geoCodes: [String], roles: [String], sourceExclusion: [String]) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.scope = scope
        self.iss = iss
        self.envAccessRestrict = envAccessRestrict
        self.geoCodes = geoCodes
        self.roles = roles
        self.sourceExclusion = sourceExclusion
    }
    
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
    public let scope: String
    public let iss: String
    public let envAccessRestrict: Bool
    public let geoCodes: [String]
    public let roles, sourceExclusion: [String]
}
public struct CLMatchAddressModel: Decodable {
    public init(matchDetails: CLMatchDetails) {
        self.matchDetails = matchDetails
    }
    
    public let matchDetails: CLMatchDetails
}
public struct CLMatchDetails: Decodable {
    public init(updateDetail: String, propertyId: Int?, matchType: String, matchRule: String, updateIndicator: String) {
        self.updateDetail = updateDetail
        self.propertyId = propertyId
        self.matchType = matchType
        self.matchRule = matchRule
        self.updateIndicator = updateIndicator
    }
    
      public let updateDetail: String
      public let propertyId: Int?
      public let matchType, matchRule, updateIndicator: String
}

struct CLProperty: Decodable {
    let contacts: [Contact]
}

struct Contact: Decodable {
    let company: Company
    let contactType: String
    let doNotCall, doNotMail: Bool
    let person: Person
    let phoneNumber: String
    let postalAddress: PostalAddress
}

struct Company: Decodable {
    let abn, acn, companyName: String
}

struct Person: Decodable {
    let firstName, lastName: String
}

struct PostalAddress: Decodable {
    let addressCareOfText, addressLine1, addressLine2, country: String
    let postcode, state, suburb: String
}
