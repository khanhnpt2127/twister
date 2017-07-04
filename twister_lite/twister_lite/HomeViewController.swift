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
    var refreshControl = UIRefreshControl()

    
    var selectedTweet = Tweet()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh!!!")
        refreshControl.addTarget(self, action: #selector(HomeViewController.fetchData), for: UIControlEvents.valueChanged)
        
        
        tweetTableView.addSubview(refreshControl)
        
        
        
        self.tweetTableView.delegate = self
        self.tweetTableView.dataSource = self
        
      
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
    
        let client = TwitterClient.sharedInstance
        
        
        client?.getHomeTimeline(success: { (tweets: [Tweet]) in
            for tweet in tweets{
                self.tweetsArr.append(tweet)
            }
            self.tweetTableView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { (error: Error) in
            
            self.refreshControl.endRefreshing()
        })
        
    }
    
    
    
    @IBAction func onSignOut(_ sender: Any) {
        
        let client = TwitterClient.sharedInstance
        
        client?.Logout()
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if sender is TweetDetailViewController {
            let nextViewController = segue.destination as! TweetDetailViewController
            
            nextViewController.currTweet = selectedTweet
        }
        
        
        
        
        
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
        
        
        
        cell.UserImageView.setImageWith((tweetsArr[indexPath.row].user?.profileUrl)!)
        cell.nameLabel.text = tweetsArr[indexPath.row].user?.name
        cell.screennameLabel.text = tweetsArr[indexPath.row].user?.screenName
        cell.contentLabel.text = tweetsArr[indexPath.row].text
        
        
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTweet = tweetsArr[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
        //selectedTweet = Tweet.init(dictionary: tweetDict)
    }
    
}
