//
//  NewTweetViewController.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/4/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tweetTF: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TwitterClient.sharedInstance
        client?.getUserInfo(success: { (user: User) in
            self.userImage.setImageWith(user.profileUrl!)
            self.nameLabel.text = user.name
            self.screennameLabel.text = user.screenName
            
        }, failure: { (error: Error) in
            //Internet problem
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTweet(_ sender: Any) {
        
        let params = NSMutableDictionary()
        let content = self.tweetTF.text
        
        
        params.setValue(content, forKey: "status")
        let client = TwitterClient.sharedInstance
        client?.postTweet(param: params)
        dismiss(animated: true, completion: nil)
        
        
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
