//
//  CoreLogicConfig.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 10/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import Foundation

public struct CoreLogicConfig {
    public let clientId: String
    public let clientSecret: String
    
    public init(clientId: String,
                clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}
