//
//  LoginViewController.swift
//  twister_lite
//
//  Created by TK Nguyen on 7/3/17.
//  Copyright © 2017 tknguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string:"twisterlite://"), scope: nil, success: { (respone: BDBOAuth1Credential?) in
            
            
            if let respone = respone {
                print(respone.token)
                
                let authURL = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(respone.token!)")
                UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
                
                
            }
            
            
            
            
        }, failure: { (error: Error?) in
            print("\(error?.localizedDescription)")
        })
        
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
