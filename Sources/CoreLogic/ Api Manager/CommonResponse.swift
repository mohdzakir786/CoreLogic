//
//  CommonResponse.swift
//  CoreLogicRealState
//
//  Created by Admin on 26/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

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
    
    public let matchDetails: CLMatchDetails?
}
public struct CLMatchDetails: Decodable {
      public let updateDetail: String
      public let propertyId: Int?
      public let matchType, matchRule, updateIndicator: String
}

struct CLProperty: Decodable {
    let contacts: [CLContact]
}

struct CLContact: Decodable {
    let company: CLCompany
    let contactType: String
    let doNotCall, doNotMail: Bool
    let person: CLPerson
    let phoneNumber: String
    let postalAddress: CLPostalAddress
}

struct CLCompany: Decodable {
    let abn, acn, companyName: String
}

struct CLPerson: Decodable {
    let firstName, lastName: String
}

struct CLPostalAddress: Decodable {
    let addressCareOfText, addressLine1, addressLine2, country: String
    let postcode, state, suburb: String
}

struct CLErrorResponse: Decodable {
    let errors: [CLErrorMessage]
}
struct CLErrorMessage: Decodable {
    let msg: String
}
struct CLAuthErrorResponse: Decodable {
    let messages: [CLAuthErrorMessage]
}
struct CLAuthErrorMessage: Decodable {
    let type: String
    let message: String
}
public struct CLCoreProperyDetail: Decodable {
    public let propertyType, propertySubType: String?
    public let beds, baths, carSpaces, lockUpGarages: Int?
    public let landArea: Int?
    public let isCalculatedLandArea: Bool?
    public let landAreaSource: String?
}
 

public struct CLPropertyLocation: Codable {
    public let singleLine, councilArea: String?
    public let councilAreaId: Int?
    public let state: String?
    public let street: CLStreet?
    public let postcode, locality: CLLocality?
    public let longitude, latitude: Double?
}


public struct CLLocality: Codable {
    public let id: Int?
    public let singleLine, name: String?
}

public struct CLStreet: Codable {
    public let id: Int?
    public let singleLine, name, nameAndNumber: String?

    
}
public struct CLSchoolPlace: Codable {
    public let latitude, longitude: Double?
    public let placeId: Int?
    public let placeName, placeType: String?

}
public struct CLSchoolDetail: Codable {
    public let hasShape: Bool
    public let latitude: Double
    public let localityId: Int
    public let localityName: String
    public let longitude: Double
    public let placeId: Int
    public let placeMetaData: CLPlaceMetaData
    public let placeName, placeSingleLineAddress, placeType: String
    public let postcodeId: Int
    public let postcodeName: String
}

// MARK: - PlaceMetaData
public struct CLPlaceMetaData: Codable {
    public let school: [CLSchool]
}

// MARK: - School
public struct CLSchool: Codable {
    public let schoolName, schoolType: String
    public let schoolGender, schoolSector: String
    public let acaraSchoolId: Int
    public let schoolWebsite: String
    public let schoolYearLow, schoolYearHigh: String
    public let schoolEnrolments: Int

   
}
