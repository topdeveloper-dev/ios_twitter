//
//  TweetViewController.swift
//  Twitter
//
//  Created by Gil Birman on 8/18/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var retweetView: UIView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var screenName: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!

  var tweet: Tweet!

  override func viewDidLoad() {
    super.viewDidLoad()

    retweetLabel.text = tweet.retweeted
    retweetView.hidden = tweet.retweeted == nil
    userLabel.text = tweet.userName
    screenName.text = tweet.screenName
    tweetTextLabel.text = tweet.text
    dateLabel.text = tweet.prettyTimeStamp
    retweetCountLabel.text = "\(tweet.retweetCount)"
    favoriteCountLabel.text = "\(tweet.favoritesCount)"
    if let avatarURL = tweet.avatarURL {
      avatarImageView.setImageWithURL(avatarURL)
    } else {
      avatarImageView.image = nil
    }
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onReplyButton(sender: AnyObject) {
    print("reply")
  }

  @IBAction func onRetweetButton(sender: AnyObject) {
    print("retweet")
  }

  @IBAction func onLikeButton(sender: AnyObject) {
    print("like")
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
