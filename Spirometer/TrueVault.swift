//
//  TruVault.swift
//  Spirometer
//
//  Created by Hugo Troche on 9/29/16.
//  Copyright © 2016 Hugo Troche. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

let BASEURL = "https://api.truevault.com/v1"
//Enter your API token here
let TOKEN:String = "<YOUR API KEY>"


typealias VaultsServiceResponse = ([Vault]?, ErrorType?) ->Void

class TrueVault {
    static let sharedInstance = TrueVault()
    
    var manager = Manager(
        configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
        serverTrustPolicyManager: ServerTrustPolicyManager(policies:[
            "test.example.com": .PinCertificates(
                certificates: ServerTrustPolicy.certificatesInBundle(),
                validateCertificateChain: true,
                validateHost: true
            ),
            "www.google.com": .DisableEvaluation
            ])
    )
    
   
    
    func loadVaults(onCompletion: VaultsServiceResponse) {
        
        var urlString = NSString(format: "%@/vaults", BASEURL) as String
        let Auth_header    = [ "Authorization" : "Basic "+self.encodeBase64(TOKEN) ]
        manager.request(.GET, urlString, headers: Auth_header, encoding: .JSON)
            .responseObject { (response: Response<VaultWrapper, NSError>) in
                if((response.result.error) != nil) {
                    onCompletion(nil, response.result.error)
                } else {
                    let result = response.result.value as VaultWrapper?
                    onCompletion(result?.vaults, nil)
                }
        }
    }
    
    func saveVault(vault:Vault, onCompletion: VaultsServiceResponse) {
        
        var urlString = NSString(format: "%@/vaults", BASEURL) as String
        
        let request = NSMutableURLRequest(URL: NSURL(string: String(urlString))!)
        request.HTTPMethod = "POST"
        request.setValue("Basic "+self.encodeBase64(TOKEN) , forHTTPHeaderField: "Authorization")
        var string = "name="+vault.name!
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = data
        
        manager.request(request)
            .responseObject { (response: Response<VaultWrapper, NSError>) -> Void in
                if((response.result.error) != nil) {
                    onCompletion(nil, response.result.error)
                } else {
                    let result = response.result.value as VaultWrapper?
                    onCompletion(result?.vaults, nil)
                }
        }
        
    }
    
    func encodeBase64(token: String) -> String {
        let compoundToken = token + ":" //the extra : is specified in the API documentation
        let data = compoundToken.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
    


}

