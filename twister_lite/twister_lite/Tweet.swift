//
//  Tweet.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/3/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var reweetCount: Int = 0
    var favoriteCount: Int = 0
    var user: User?
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        reweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        let userDict = dictionary["user"] as? NSDictionary
        
        user = User(dictionary: userDict!)
        
        
        let timestampString = dictionary["created_at"] as? String
        
        let formater = DateFormatter()
        formater.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formater.date(from: timestampString!)
        
        
    }
    
    
    class func tweetWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        
        
        
        return tweets
    }
    
    
    
    
}
