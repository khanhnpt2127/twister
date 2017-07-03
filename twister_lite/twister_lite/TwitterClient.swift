//
//  TwitterClient.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/3/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let baseUrl = URL(string: "https://api.twitter.com/")
let consumerKey = "62zHcuZVjjIhQn7WjBpL5E0KI"
let consumerSecret = "2nDbfNlhqCv92pWj8x2vxUqhjciSU1wWg7XCDorVQjdlADUqi6"




class TwitterClient: BDBOAuth1SessionManager {
    
    static var sharedInstance =  TwitterClient(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)
    
    
    func getUserInfo(){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            
            if let respon = response {
                let user = respon as! NSDictionary
                print(user["name"] as! String)
                print(user["screen_name"] as! String)
                print(user["profile_image_url_https"] as! String)
                
            }
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
        })
        
        
    }
}

