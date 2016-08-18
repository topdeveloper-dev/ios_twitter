//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/17/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var tweetTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let avatarURL = User.currentUser?.avatarURL {
      avatarImageView.setImageWithURL(avatarURL)
    }
    userNameLabel.text = User.currentUser?.name
    screenNameLabel.text = User.currentUser?.screenName
    tweetTextView.text = ""
    tweetTextView.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func onTweetButton(sender: AnyObject) {
    tweetTextView.resignFirstResponder()

    TwitterClient.sharedInstance.tweet(tweetTextView.text, success: { 
      self.dismissViewControllerAnimated(true, completion: nil)
    }) { (error: NSError) in
      print("error", error)
    }
  }

  @IBAction func onCancelButton(sender: AnyObject) {
    tweetTextView.resignFirstResponder()
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
