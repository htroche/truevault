//
//  VaultWrapper.swift
//  Spirometer
//
//  Created by Hugo Troche on 9/29/16.
//  Copyright © 2016 Hugo Troche. All rights reserved.
//

import Foundation
import ObjectMapper

class VaultWrapper:NSObject, Mappable {
    
    var transactionID: String?
    var vaults: [Vault]?
    var status: String?
    
    required init?(_ map: Map){
        
    }
    
    
    func mapping(map: Map) {
        status <- map["result"]
        transactionID <- map["transaction_id"]
        vaults <- map["vaults"]
    }
}