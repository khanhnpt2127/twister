//
//  User.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/3/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagLine: String?
    
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagLine = dictionary["description"] as? String
        
        
    }
    
    
    static var _currentUser: User?
    class var currenUser: User? {
        get{
            
            if _currentUser == nil{
                let user = UserDefaults.standard.value(forKey: "currentUserData") as? NSData
                
                if let userData = user {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                    
                }
                
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                UserDefaults.standard.setValue(data, forKey: "currentUserData")
            }
            else{
                UserDefaults.standard.setValue(nil, forKey: "currentUserData")
            }
            UserDefaults.standard.synchronize()
            
        }
    }
    
    
    
    
    
}
