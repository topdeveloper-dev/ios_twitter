//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Gil Birman on 8/17/16.
//  Copyright © 2016 Gil Birman. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

  @IBOutlet weak var retweetView: UIView!
  @IBOutlet weak var retweetLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var retweetedLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var screenName: UILabel!

  var navigationController: UINavigationController?

  var tweet: Tweet! {
    didSet {
      retweetLabel.text = tweet.retweeted
      retweetView.hidden = tweet.retweeted == nil
      userLabel.text = tweet.userName
      screenName.text = tweet.screenName
      tweetTextLabel.text = tweet.text
      dateLabel.text = tweet.prettyTimeStamp
      if let avatarURL = tweet.avatarURL {
        avatarImageView.setImageWithURL(avatarURL)
      } else {
        avatarImageView.image = nil
      }
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(TweetTableViewCell.avatarImageTapped))
    avatarImageView.userInteractionEnabled = true
    avatarImageView.addGestureRecognizer(tapGestureRecognizer)
  }

  func avatarImageTapped() {
    guard let navigationController = navigationController else { return }

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController

    profileViewController.userScreenName = tweet.screenName

    navigationController.pushViewController(profileViewController, animated: true)
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
