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
    
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    
    
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                print(response.token)
               
                
                self.loginSuccess?()
                
                
                
            }
        }, failure: { (error: Error?) in
            
            self.loginFailure?(error!)
            print("\(error.debugDescription)")
        })
    }
    
    
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->()){
        
        loginSuccess = success
        loginFailure = failure
        
        fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string:"twisterlite://"), scope: nil, success: { (respone: BDBOAuth1Credential?) in
            
            
            if let respone = respone {
                print(respone.token)
                
                let authURL = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(respone.token!)")
                UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
                
                
            }
            
            
            
            
        }, failure: { (error: Error?) in
            
            self.loginFailure?(error!)
            print("\(String(describing: error?.localizedDescription))")
        })
        
    
    }
    
    
    func getUserInfo(){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            
            if let respon = response {
                
                let userDictionary = respon as? NSDictionary
                
                let user = User(dictionary: userDictionary!)
                
//                print("\(String(describing: user.name))")
//                print("\(String(describing: user.profileUrl))")
//                print("\(String(describing: user.screenName))")
//                print("\(String(describing: user.tagLine))")
//                
                
                
            }
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error)
        })
        
        
    }
    
    
    
    func getHomeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
    
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            
            if let respon = response {
                
                let dictionaries = respon as? [NSDictionary]
                
                let tweets = Tweet.tweetWithArray(dictionaries: dictionaries!)
                
                
                success(tweets)
                
                
                
            }
            
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
        
    }
    
    
    
}

