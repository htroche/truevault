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



typealias VaultsServiceResponse = ([Vault]?, Error?) ->Void

class TrueVault {
    static let sharedInstance = TrueVault()
    
   
    
    func loadVaults(_ onCompletion: @escaping VaultsServiceResponse) {
        
        
        var urlString = NSString(format: "%@/vaults", BASEURL) as String
        
        //let request = NSMutableURLRequest(url: URL(string: String(urlString))!)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic "+self.encodeBase64(TOKEN) , forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request)
            .responseObject(completionHandler: { (response: DataResponse<VaultWrapper> ) in
                if((response.result.error) != nil) {
                    onCompletion(nil, response.result.error)
                } else {
                    let result = response.result.value as VaultWrapper?
                    onCompletion(result?.vaults, nil)
                }
            })

    }
    
    func saveVault(_ vault:Vault, onCompletion: @escaping VaultsServiceResponse) {
        
        var urlString = NSString(format: "%@/vaults", BASEURL) as String
        
        //let request = NSMutableURLRequest(url: URL(string: String(urlString))!)
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic "+self.encodeBase64(TOKEN) , forHTTPHeaderField: "Authorization")
        var string = "name="+vault.name!
        let data = string.data(using: String.Encoding.utf8)
        
        request.httpBody = data
        
        Alamofire.request(request)
            .responseObject(completionHandler: { (response: DataResponse<VaultWrapper> ) in
                if((response.result.error) != nil) {
                    onCompletion(nil, response.result.error)
                } else {
                    let result = response.result.value as VaultWrapper?
                    onCompletion(result?.vaults, nil)
                }
            })
        
    }
    
    func encodeBase64(_ token: String) -> String {
        let compoundToken = token + ":" //the extra : is specified in the API documentation
        let data = compoundToken.data(using: String.Encoding.utf8)
        return data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    


}

