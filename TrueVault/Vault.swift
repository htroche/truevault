//
//  Vault.swift
//  Spirometer
//
//  Created by Hugo Troche on 9/29/16.
//  Copyright © 2016 Hugo Troche. All rights reserved.
//

import Foundation
import ObjectMapper

class Vault:NSObject, Mappable {
    
    var id: String?
    var name: String?
    
    required init?(map: Map){
        
    }
    
    override init() {
        
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
