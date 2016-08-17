//
//  LoginViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/15/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
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


  @IBAction func onLoginButton(sender: AnyObject) {
    let client = TwitterClient.sharedInstance
    client.login({ 
      print("llll")
      self.performSegueWithIdentifier("loginSegue", sender: nil)
    }) { (error:NSError) in
      print("error")
    }
  }
  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
