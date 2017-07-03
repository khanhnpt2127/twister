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
                
                let userDictionary = respon as? NSDictionary
                
                let user = User(dictionary: userDictionary!)
                
                print("\(String(describing: user.name))")
                print("\(String(describing: user.profileUrl))")
                print("\(String(describing: user.screenName))")
                print("\(String(describing: user.tagLine))")
                
                
                
            }
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
        })
        
        
    }
    
    
    
    func getHomeTimeline(){
    
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            
            if let respon = response {
                
                let dictionaries = respon as? [NSDictionary]
                
                let tweets = Tweet.tweetWithArray(dictionaries: dictionaries!)
                
                
                
                for tweet in tweets {
                    print("\(tweet.text)")
                }
                
                
                
                
            }
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
        })
        
    }
    
    
    
}

