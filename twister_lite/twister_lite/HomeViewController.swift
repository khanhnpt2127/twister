//
//  HomeViewController.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/3/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tweetTableView: UITableView!
    var tweetsArr = [Tweet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        
        let client = TwitterClient.sharedInstance
        
        
        client?.getHomeTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets{
                self.tweetsArr.append(tweet)
            }
            self.tweetTableView.reloadData()
        }, failure: { (error: Error) in
            
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetTableViewCell
        
        cell.nameLabel.text = tweetsArr[indexPath.row].text
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArr.count
    }
    
}
